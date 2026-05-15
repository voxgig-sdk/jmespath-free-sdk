<?php
declare(strict_types=1);

// JmespathFree SDK utility: result_body

class JmespathFreeResultBody
{
    public static function call(JmespathFreeContext $ctx): ?JmespathFreeResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
