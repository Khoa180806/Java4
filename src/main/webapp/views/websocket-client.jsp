<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Chat Client</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .chat-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 600px;
            height: 600px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-header h1 {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }

        .back-button {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .connection-status {
            padding: 10px;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
        }

        .connection-status.connected {
            background: #d4edda;
            color: #155724;
        }

        .connection-status.disconnected {
            background: #f8d7da;
            color: #721c24;
        }

        .messages-container {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: #f8f9fa;
        }

        .message {
            margin-bottom: 15px;
            padding: 12px 15px;
            border-radius: 8px;
            background: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.3s ease-out;
        }

        .message.system {
            background: #fff3cd;
            color: #856404;
            font-style: italic;
            text-align: center;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
            font-weight: 500;
        }

        .message.sent {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin-left: 20%;
        }

        .message.received {
            background: white;
            margin-right: 20%;
        }

        .message-sender {
            font-weight: bold;
            font-size: 12px;
            margin-bottom: 5px;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-time {
            font-size: 11px;
            color: #6c757d;
            margin-top: 5px;
        }

        .input-container {
            padding: 20px;
            background: white;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 10px;
        }

        #messageInput {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s;
        }

        #messageInput:focus {
            border-color: #667eea;
        }

        #sendButton {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        #sendButton:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        #sendButton:active {
            transform: translateY(0);
        }

        #sendButton:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        .messages-container::-webkit-scrollbar {
            width: 8px;
        }

        .messages-container::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .messages-container::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 4px;
        }

        .messages-container::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        @media (max-width: 768px) {
            .chat-container {
                height: 100vh;
                max-width: 100%;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
            <h1>💬 WebSocket Chat Room</h1>
            <a href="${pageContext.request.contextPath}/" class="back-button">← Quay lại</a>
        </div>
        <div class="connection-status disconnected" id="connectionStatus">
            Đang kết nối...
        </div>
        <div class="messages-container" id="messagesContainer">
            <div class="message system">
                Chào mừng đến với chat room! Đang kết nối đến server...
            </div>
        </div>
        <div class="input-container">
            <input 
                type="text" 
                id="messageInput" 
                placeholder="Nhập tin nhắn..." 
                disabled
                maxlength="500"
            >
            <button id="sendButton" disabled>Send</button>
        </div>
    </div>

    <script>
        let websocket;
        let username;
        const messagesContainer = document.getElementById('messagesContainer');
        const messageInput = document.getElementById('messageInput');
        const sendButton = document.getElementById('sendButton');
        const connectionStatus = document.getElementById('connectionStatus');

        function connect() {
            username = prompt('Nhập tên của bạn:', 'User' + Math.floor(Math.random() * 1000));
            
            if (!username || username.trim() === '') {
                username = 'User' + Math.floor(Math.random() * 1000);
            }
            
            const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
            const host = window.location.host;
            const contextPath = '${pageContext.request.contextPath}';
            const wsUrl = protocol + '//' + host + contextPath + '/chat/' + encodeURIComponent(username);
            
            console.log('Connecting to WebSocket:', wsUrl);
            
            try {
                websocket = new WebSocket(wsUrl);
                
                websocket.onopen = function(event) {
                    console.log('WebSocket connected:', event);
                    addSimpleMessage('Đã kết nối đến server thành công!', 'system');
                    updateConnectionStatus(true);
                    messageInput.disabled = false;
                    sendButton.disabled = false;
                    messageInput.focus();
                };
                
                websocket.onmessage = function(event) {
                    console.log('Message received:', event.data);
                    try {
                        const message = JSON.parse(event.data);
                        handleMessage(message);
                    } catch (error) {
                        console.error('Error parsing message:', error);
                        addSimpleMessage('Lỗi khi phân tích tin nhắn', 'error');
                    }
                };
                
                websocket.onerror = function(event) {
                    console.error('WebSocket error:', event);
                    addSimpleMessage('Lỗi kết nối WebSocket! Vui lòng kiểm tra server.', 'error');
                    updateConnectionStatus(false);
                };
                
                websocket.onclose = function(event) {
                    console.log('WebSocket closed:', event);
                    let reason = event.reason || 'Không rõ';
                    addSimpleMessage('Kết nối đã bị đóng. Mã: ' + event.code + ' - Lý do: ' + reason, 'error');
                    updateConnectionStatus(false);
                    messageInput.disabled = true;
                    sendButton.disabled = true;
                    
                    setTimeout(function() {
                        addSimpleMessage('Đang thử kết nối lại...', 'system');
                        connect();
                    }, 3000);
                };
                
            } catch (error) {
                console.error('Error creating WebSocket:', error);
                addSimpleMessage('Không thể tạo kết nối WebSocket: ' + error.message, 'error');
            }
        }

        function sendMessage() {
            const text = messageInput.value.trim();
            
            if (text === '') {
                return;
            }
            
            if (websocket && websocket.readyState === WebSocket.OPEN) {
                try {
                    const message = {
                        text: text,
                        type: 2,
                        count: null,
                        sender: username
                    };
                    websocket.send(JSON.stringify(message));
                    messageInput.value = '';
                    messageInput.focus();
                } catch (error) {
                    console.error('Error sending message:', error);
                    addSimpleMessage('Lỗi khi gửi tin nhắn: ' + error.message, 'error');
                }
            } else {
                addSimpleMessage('Không thể gửi tin nhắn. Chưa kết nối đến server.', 'error');
            }
        }

        function handleMessage(message) {
            const messageDiv = document.createElement('div');
            
            if (message.type === 0 || message.type === 1) {
                messageDiv.className = 'message system';
                messageDiv.innerHTML = '<div>' + message.text + '</div>' +
                                     '<div class="message-time">Số người online: ' + message.count + ' | ' + 
                                     new Date().toLocaleTimeString('vi-VN') + '</div>';
            } else if (message.type === 2) {
                const isSent = message.sender === username;
                messageDiv.className = 'message ' + (isSent ? 'sent' : 'received');
                
                let content = '';
                if (!isSent) {
                    content += '<div class="message-sender">' + message.sender + '</div>';
                }
                content += '<div>' + message.text + '</div>' +
                          '<div class="message-time">' + new Date().toLocaleTimeString('vi-VN') + '</div>';
                
                messageDiv.innerHTML = content;
            }
            
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function addSimpleMessage(text, type) {
            type = type || 'normal';
            
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message' + (type !== 'normal' ? ' ' + type : '');
            
            const messageText = document.createElement('div');
            messageText.textContent = text;
            messageDiv.appendChild(messageText);
            
            const timeDiv = document.createElement('div');
            timeDiv.className = 'message-time';
            timeDiv.textContent = new Date().toLocaleTimeString('vi-VN');
            messageDiv.appendChild(timeDiv);
            
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function updateConnectionStatus(connected) {
            if (connected) {
                connectionStatus.textContent = 'Đã kết nối - ' + username;
                connectionStatus.className = 'connection-status connected';
            } else {
                connectionStatus.textContent = 'Ngắt kết nối';
                connectionStatus.className = 'connection-status disconnected';
            }
        }

        sendButton.addEventListener('click', sendMessage);
        
        messageInput.addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        });

        connect();
    </script>
</body>
</html>
