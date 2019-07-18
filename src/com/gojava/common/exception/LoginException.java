package com.gojava.common.exception;

public class LoginException extends RuntimeException {

    private static final long serialVersionUID = 4275394784148073067L;

    public LoginException() {
        super();
    }

    public LoginException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginException(String message) {
        super(message);
    }

    public LoginException(Throwable cause) {
        super(cause);
    }

}
