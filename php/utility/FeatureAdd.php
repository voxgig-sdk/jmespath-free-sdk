<?php
declare(strict_types=1);

// JmespathFree SDK utility: feature_add

class JmespathFreeFeatureAdd
{
    public static function call(JmespathFreeContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
