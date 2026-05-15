<?php
declare(strict_types=1);

// JmespathFree SDK utility: result_headers

class JmespathFreeResultHeaders
{
    public static function call(JmespathFreeContext $ctx): ?JmespathFreeResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
