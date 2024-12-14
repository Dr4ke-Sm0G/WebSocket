<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat - Login</title>
</head>
<body>
    <h2>Entrez votre nom pour accéder au chat</h2>
    <form action="chat.jsp" method="GET">
        <input type="text" name="username" placeholder="Votre nom" required />
        <input type="submit" value="Entrer dans le chat" />
    </form>
</body>
</html>
