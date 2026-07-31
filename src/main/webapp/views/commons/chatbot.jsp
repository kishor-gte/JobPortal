<style>


  /* ========== CHAT WIDGET ========== */
  .chat-widget {
    position: fixed;
    bottom: 28px;
    right: 28px;
    z-index: 9999;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 12px;
  }

  .chat-container {
    display: none;
    flex-direction: column;
    width: 360px;
    height: 480px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.18);
    overflow: hidden;
    border: 1px solid rgba(0,0,0,0.07);
    animation: slideUp 0.3s ease;
  }

  .chat-container.active {
    display: flex;
  }

  @keyframes slideUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .chat-header {
    background: var(--gradient-primary);
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-shrink: 0;
  }

  .chat-header h3 {
    color: #fff;
    font-size: 1rem;
    font-weight: 700;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .chat-header button {
    background: rgba(255,255,255,0.2);
    border: none;
    color: #fff;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
  }

  .chat-header button:hover { background: rgba(255,255,255,0.35); }

  .chat-messages {
    flex: 1;
    overflow-y: auto;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    background: #f8fafc;
  }

  .chat-messages .message {
    max-width: 80%;
    padding: 10px 14px;
    border-radius: 16px;
    font-size: 0.88rem;
    line-height: 1.5;
    word-wrap: break-word;
  }

  .chat-messages .message.bot {
    background: #fff;
    color: var(--slate-700);
    border-radius: 4px 16px 16px 16px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    align-self: flex-start;
  }

  .chat-messages .message.user {
    background: var(--gradient-primary);
    color: #fff;
    border-radius: 16px 16px 4px 16px;
    align-self: flex-end;
  }

  .typing-indicator {
    display: none;
    padding: 10px 16px;
    gap: 5px;
    align-items: center;
    background: #f8fafc;
  }

  .typing-indicator span {
    width: 8px;
    height: 8px;
    background: var(--primary);
    border-radius: 50%;
    opacity: 0.4;
    animation: typingBounce 1.2s infinite;
  }

  .typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
  .typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

  @keyframes typingBounce {
    0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
    30% { transform: translateY(-6px); opacity: 1; }
  }

  .chat-input-container {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    background: #fff;
    border-top: 1px solid rgba(0,0,0,0.06);
    gap: 10px;
    flex-shrink: 0;
  }

  .chat-input {
    flex: 1;
    border: 1px solid rgba(0,0,0,0.1);
    border-radius: 50px;
    padding: 10px 16px;
    font-size: 0.88rem;
    outline: none;
    font-family: 'Outfit', sans-serif;
    transition: border-color 0.2s;
  }

  .chat-input:focus { border-color: var(--primary); }

  .chat-send {
    width: 38px;
    height: 38px;
    background: var(--gradient-primary);
    border: none;
    border-radius: 50%;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 0.85rem;
    flex-shrink: 0;
    transition: transform 0.2s;
  }

  .chat-send:hover { transform: scale(1.1); }

  .chat-button {
    width: 56px;
    height: 56px;
    background: var(--gradient-primary);
    border: none;
    border-radius: 50%;
    color: #fff;
    font-size: 1.4rem;
    cursor: pointer;
    box-shadow: 0 8px 24px rgba(25, 167, 123,0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .chat-button:hover {
    transform: scale(1.1);
    box-shadow: 0 12px 30px rgba(25, 167, 123,0.5);
  }

</style>
<div class="chat-widget">
  <div class="chat-container" id="chatContainer">
    <div class="chat-header"><h3><i class="fas fa-robot"></i>JobU AI Assistant</h3><button onclick="toggleChat()"><i class="fas fa-times"></i></button></div>
<script>
  function toggleChat() { 
    const container = document.getElementById('chatContainer'); 
    const button = document.getElementById('chatButton'); 
    if(container && button) { 
      container.classList.toggle('active'); 
      button.style.display = container.classList.contains('active') ? 'none' : 'flex'; 
    } 
  }
  function handleKeyPress(e) { if(e.key === 'Enter') sendMessage(); }
  async function sendMessage() { 
    const input = document.getElementById('chatInput'); 
    const msg = input.value.trim(); 
    if(!msg) return; 
    addMessage(msg, 'user'); 
    input.value = ''; 
    showTypingIndicator(); 
    try { 
      const res = await fetch((window.location.pathname.includes('/jobportal/') ? '/jobportal' : '') + '/api/chat', { 
        method: 'POST', 
        headers: { 'Content-Type': 'application/json' }, 
        body: JSON.stringify({ message: msg }) 
      }); 
      hideTypingIndicator(); 
      if(res.ok) { const d = await res.json(); addMessage(d.response, 'bot'); } 
      else addMessage('Having trouble connecting. Please try again.', 'bot'); 
    } catch(e) { 
      hideTypingIndicator(); 
      addMessage('I\'m here to help with job searching, company registration, and more!', 'bot'); 
    } 
  }
  function addMessage(t, s) { 
    const m = document.getElementById('chatMessages'); 
    if(m) { const d = document.createElement('div'); d.className = 'message ' + s; d.textContent = t; m.appendChild(d); m.scrollTop = m.scrollHeight; } 
  }
  function showTypingIndicator() { const i = document.getElementById('typingIndicator'); if(i) i.style.display = 'flex'; }
  function hideTypingIndicator() { const i = document.getElementById('typingIndicator'); if(i) i.style.display = 'none'; }

</script>
