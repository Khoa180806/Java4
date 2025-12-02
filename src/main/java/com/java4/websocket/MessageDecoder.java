package com.java4.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java4.entity.Message;
import jakarta.websocket.DecodeException;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;

public class MessageDecoder implements Decoder.Text<Message> {
    
    private static final ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public Message decode(String s) throws DecodeException {
        try {
            return objectMapper.readValue(s, Message.class);
        } catch (Exception e) {
            throw new DecodeException(s, "Unable to decode message", e);
        }
    }
    
    @Override
    public boolean willDecode(String s) {
        try {
            objectMapper.readValue(s, Message.class);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    @Override
    public void init(EndpointConfig config) {
    }
    
    @Override
    public void destroy() {
    }
}
