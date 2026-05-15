<?php
declare(strict_types=1);

// JmespathFree SDK utility: prepare_body

class JmespathFreePrepareBody
{
    public static function call(JmespathFreeContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
