package com.java4.websocket;

import com.java4.entity.Message;
import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint(
    value = "/chat/{username}",
    encoders = {MessageEncoder.class},
    decoders = {MessageDecoder.class}
)
public class ChatServerEndpoint {
    
    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();
    private static final Map<String, String> users = new ConcurrentHashMap<>();
    
    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) {
        sessions.add(session);
        users.put(session.getId(), username);
        
        Message message = new Message();
        message.setText(username + " đã tham gia chat!");
        message.setType(0);
        message.setCount(sessions.size());
        message.setSender(null);
        
        broadcast(message);
    }
    
    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        String username = users.remove(session.getId());
        
        Message message = new Message();
        message.setText(username + " đã rời khỏi chat!");
        message.setType(1);
        message.setCount(sessions.size());
        message.setSender(null);
        
        broadcast(message);
    }
    
    @OnMessage
    public void onMessage(Message message, Session session) {
        String username = users.get(session.getId());
        
        message.setType(2);
        message.setCount(null);
        message.setSender(username);
        
        broadcast(message);
    }
    
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket error for session " + session.getId());
        throwable.printStackTrace();
    }
    
    private void broadcast(Message message) {
        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendObject(message);
                } catch (IOException | EncodeException e) {
                    System.err.println("Error broadcasting message to session " + session.getId());
                    e.printStackTrace();
                }
            }
        }
    }
}
