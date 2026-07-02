import os
import re

def update_jsp_files(directory):
    # Context path variable
    context_path = '${pageContext.request.contextPath}'
    
    # Patterns to match: href="...", src="...", action="..."
    # We use a broad match and then filter in the substitution function
    pattern = re.compile(r'(\b(href|src|action)\s*=\s*(["\']))([^"\']*)(["\'])', re.IGNORECASE)

    # Exclude list for values that shouldn't be prefixed
    # 1. External links (http://, https://, //)
    # 2. Already prefixed (${...})
    # 3. Fragments (#...)
    # 4. Protocols (javascript:, mailto:, tel:)
    # 5. Data URLs (data:)
    # 6. JSP includes/directives are not caught by this regex usually, but good to be aware
    
    exclude_prefixes = ('http://', 'https://', '//', '${', '#', 'javascript:', 'mailto:', 'tel:', 'data:')

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.jsp'):
                path = os.path.join(root, file)
                # Skip some known header/footer if needed, but the user said ALL
                
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                def replace_func(match):
                    full_prefix = match.group(1) # e.g. href="
                    attr = match.group(2).lower() # e.g. href
                    quote = match.group(3) # " or '
                    value = match.group(4) # existing value
                    suffix = match.group(5) # " or '

                    # Check if we should ignore this value
                    if value.strip() == "" or any(value.lower().startswith(ex) for ex in exclude_prefixes):
                        return match.group(0)
                    
                    # If it's already an absolute path starting with /
                    if value.startswith('/'):
                        return f'{full_prefix}{context_path}{value}{suffix}'
                    else:
                        # It's a relative path (e.g. "assets/..." or "login")
                        # We prefix with contextPath/
                        return f'{full_prefix}{context_path}/{value}{suffix}'

                new_content = pattern.sub(replace_func, content)

                if new_content != content:
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Updated {path}")

if __name__ == "__main__":
    target_dir = r"c:\Users\kisho\OneDrive\Desktop\jobportal-main\jobportal-main\job portal\src\main\webapp\views"
    update_jsp_files(target_dir)
