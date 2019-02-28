RFC
---

Logger Interface
================

This document describes a common interface for logging libraries.

The main goal is to allow libraries to receive a `His\Log\LoggerInterface`
object and write logs to it in a simple and universal way. Frameworks
and CMSs that have custom needs MAY extend the interface for their own
purpose, but SHOULD remain compatible with this document. This ensures
that the third-party libraries an application uses can write to the
centralized application logs.

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [RFC 2119][].

The word `implementor` in this document is to be interpreted as someone
implementing the `LoggerInterface` in a log-related library or framework.
Users of loggers are referred to as `user`.

[RFC 2119]: http://tools.ietf.org/html/rfc2119

## 1. Specification

### 1.1 Basics

- The `LoggerInterface` exposes eight methods to write logs to the eight
  [RFC 5424][] levels (debug, info, notice, warning, error, critical, alert,
  emergency).

- A ninth method, `log`, accepts a log level as the first argument. Calling this
  method with one of the log level constants MUST have the same result as
  calling the level-specific method. Calling this method with a level not
  defined by this specification MUST throw a `His\Log\Exception\InvalidArgumentException`
  if the implementation does not know about the level. Users SHOULD NOT use a
  custom level without knowing for sure the current implementation supports it.

[RFC 5424]: http://tools.ietf.org/html/rfc5424

### 1.2 Message

- Every method accepts a string as the message. Implementors MAY have special
  handling for the passed objects. If that is not the case, implementors MUST
  cast it to a string.

- The message MAY contain placeholders which implementors MAY replace with
  values from the context array.

  Placeholder names MUST correspond to keys in the context array.

  Placeholder names MUST be delimited with a single opening brace `{` and
  a single closing brace `}`. There MUST NOT be any whitespace between the
  delimiters and the placeholder name.

  Placeholder names SHOULD be composed only of the characters `A-Z`, `a-z`,
  `0-9`, underscore `_`, and period `.`. The use of other characters is
  reserved for future modifications of the placeholders specification.

  Implementors MAY use placeholders to implement various escaping strategies
  and translate logs for display. Users SHOULD NOT pre-escape placeholder
  values since they can not know in which context the data will be displayed.

### 1.3 Context

- Every method accepts an array as context data. This is meant to hold any
  extraneous information that does not fit well in a string. The array can
  contain anything. Implementors MUST ensure they treat context data with
  as much lenience as possible. A given value in the context MUST NOT throw
  an exception nor raise any php error, warning or notice.

- If an `Exception` object is passed in the context data, it MUST be in the
  `'exception'` key. Logging exceptions is a common pattern and this allows
  implementors to extract a stack trace from the exception when the log
  backend supports it. Implementors MUST still verify that the `'exception'`
  key is actually an `Exception` before using it as such, as it MAY contain
  anything.

### 1.4 Helper classes and interfaces

- The `His\Log\LogLevel` enum holds constants for the eight log levels.

- The `His\Log\LogLevelName` enum holds constants for naming the log levels;

- The `His\Log\LogLevelNameMap` provides a mapping method from the log level
  code to the name.