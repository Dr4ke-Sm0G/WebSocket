<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
    String username = request.getParameter("username");
    if (username == null || username.trim().isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat</title>
<style>
    #chatArea {
        width: 500px;
        height: 300px;
        border: 1px solid #000;
        overflow-y: scroll;
        margin-bottom: 10px;
    }
</style>
</head>
<body>
    <h2>Bienvenue, <%= username %> !</h2>
    <div id="chatArea"></div>
    <input type="text" id="messageInput" placeholder="Votre message..." />
    <button id="sendBtn">Envoyer</button>

    <script>
        var username = "<%= URLEncoder.encode(username, "UTF-8") %>";
		var ws = new WebSocket("ws://" + window.location.host + "<%= request.getContextPath() %>/chat");
        var chatArea = document.getElementById("chatArea");
        var messageInput = document.getElementById("messageInput");
        var sendBtn = document.getElementById("sendBtn");
        
        ws.onopen = function() {
            // Envoyer un message de "notification" d'arrivée
            ws.send(username + " a rejoint la conversation");
        };
        
        ws.onmessage = function(event) {
            var msg = event.data;
            var newMsgDiv = document.createElement("div");
            newMsgDiv.textContent = msg;
            chatArea.appendChild(newMsgDiv);
            chatArea.scrollTop = chatArea.scrollHeight; // pour rester en bas du chat
        };
        
        ws.onclose = function() {
            var newMsgDiv = document.createElement("div");
            newMsgDiv.textContent = "La connexion est fermée.";
            chatArea.appendChild(newMsgDiv);
        };
        
        sendBtn.onclick = function() {
            var message = messageInput.value.trim();
            if (message) {
                ws.send(username + ": " + message);
                messageInput.value = "";
            }
        };

        // Envoyer le message en appuyant sur Enter
        messageInput.addEventListener("keyup", function(event) {
            if (event.key === 'Enter') {
                sendBtn.click();
            }
        });
    </script>
</body>
</html>
