package com.gojava.common.exception;

public class RepeatLoginException extends RuntimeException {

    private static final long serialVersionUID = -7943494202618868884L;

    public RepeatLoginException() {
        super();
    }

    public RepeatLoginException(String message, Throwable cause) {
        super(message, cause);
    }

    public RepeatLoginException(String message) {
        super(message);
    }

    public RepeatLoginException(Throwable cause) {
        super(cause);
    }

}
