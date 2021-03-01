# Redis-to-HTTP proxy

Currently there are only two distinct pieces functionality implemented, specifically proxying:
  * of pub/sub subscriptions onto a websocket
  * the [`LRANGE`](https://redis.io/commands/lrange) command in both standard and domain-specific ways

However, combined these allow relatively powerful client implementations.

### WebSocket pub/sub subscription proxying

* specify `channel` in path to `GET` request `/sub/[channel]`, providing valid credentials as Basic authorization
  * credentials are matched against those stored in `users.json`, a simple username-as-key to client-as-password mapping
* if `/sub/...` request was valid & authorized, it will return a *one-time* token `SUB_TOKEN`
* use the token as the sole query parameter to the websocket endpoint to start receiving data, e.g. `/ws/sub?SUB_TOKEN`

The entirety of the aforementioned procedure can be perfomed on the CLI via `wscat` and `curl`:

```
wscat -c ws://HOST:PORT/ws/sub?`curl -H "Authorization: Basic B64_CRED" http://HOST:PORT/sub/CHANNEL`
```

where `HOST`, `PORT`, `B64_CRED` & `CHANNEL` should be replaced with appropriate values.

### `LRANGE` proxying

Make `GET` requests to `/list/[key]?<options>`, where `<options>` may be composed of:

| Name | Description|
| --- | --- |
| `start` | directly corresponds to the `start` argument of [`LRANGE`](https://redis.io/commands/lrange) |
| `end` | directly corresponds to the `stop` argument of [`LRANGE`](https://redis.io/commands/lrange) |