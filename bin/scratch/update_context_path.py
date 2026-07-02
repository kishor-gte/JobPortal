import os
import re

def update_jsp_files(directory):
    # Regex to match href or src starting with / and not already prefixed with ${pageContext.request.contextPath}
    # We want to match: href="/something" or src="/something"
    # But NOT: href="http://...", href="https://...", href="#...", href="javascript:...", href="${pageContext.request.contextPath}/..."
    
    # Pattern for anchor tags: <a ... href="/..." ...>
    # Group 1: prefix (e.g., <a ... href=")
    # Group 2: path (starts with /)
    # Group 3: suffix (e.g., ")
    href_pattern = re.compile(r'(<a\s+[^>]*href=["\'])(/)([^"\']*["\'])', re.IGNORECASE)
    
    # Pattern for image tags: <img ... src="/..." ...>
    img_pattern = re.compile(r'(<img\s+[^>]*src=["\'])(/)([^"\']*["\'])', re.IGNORECASE)

    # We also check for occurrences that already have context path to avoid double prefixing
    context_path = '${pageContext.request.contextPath}'

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.jsp'):
                path = os.path.join(root, file)
                print(f"Processing {path}...")
                
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                new_content = content
                
                # Replace href="/..." with href="${pageContext.request.contextPath}/..."
                # Only if not already prefixed
                def href_replace(match):
                    prefix = match.group(1)
                    slash = match.group(2)
                    rest = match.group(3)
                    if context_path in prefix:
                        return match.group(0)
                    return f'{prefix}{context_path}{slash}{rest}'

                new_content = href_pattern.sub(href_replace, new_content)

                # Replace src="/..." with src="${pageContext.request.contextPath}/..."
                def img_replace(match):
                    prefix = match.group(1)
                    slash = match.group(2)
                    rest = match.group(3)
                    if context_path in prefix:
                        return match.group(0)
                    return f'{prefix}{context_path}{slash}{rest}'

                new_content = img_pattern.sub(img_replace, new_content)

                if new_content != content:
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"  Updated {path}")

if __name__ == "__main__":
    target_dir = r"c:\Users\kisho\OneDrive\Desktop\jobportal-main\jobportal-main\job portal\src\main\webapp\views"
    update_jsp_files(target_dir)
