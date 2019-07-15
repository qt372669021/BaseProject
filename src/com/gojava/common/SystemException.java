package com.gojava.common;

public class SystemException extends RuntimeException {

    private static final long serialVersionUID = 7195919773763344258L;

    public SystemException() {
        super();
    }

    public SystemException(String message, Throwable cause) {
        super(message, cause);
    }

    public SystemException(String message) {
        super(message);
    }

    public SystemException(Throwable cause) {
        super(cause);
    }
}
