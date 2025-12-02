package com.java4.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/text/chat")
public class TextChatServerEndpoint {
    
    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();
    
    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        broadcast("Someone joined the chat!");
    }
    
    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        broadcast("Someone left the chat!");
    }
    
    @OnMessage
    public void onMessage(String message, Session session) {
        broadcast(message);
    }
    
    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }
    
    private void broadcast(String message) {
        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
