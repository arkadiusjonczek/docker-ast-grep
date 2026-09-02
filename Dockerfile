FROM alpine:3.23.5 AS builder

RUN apk add --no-cache curl unzip

RUN curl -L "https://github.com/ast-grep/ast-grep/releases/download/0.45.3/app-x86_64-unknown-linux-gnu.zip" -o ast-grep.zip \
    && unzip ast-grep.zip \
    && mv ast-grep /usr/local/bin/sg

FROM alpine:3.23.5

RUN apk add --no-cache libgcc gcompat

COPY --from=builder /usr/local/bin/sg /usr/local/bin/sg

WORKDIR /src

ENTRYPOINT ["sg"]
CMD ["--help"]
