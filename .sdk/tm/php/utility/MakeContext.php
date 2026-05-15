<?php
declare(strict_types=1);

// JmespathFree SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class JmespathFreeMakeContext
{
    public static function call(array $ctxmap, ?JmespathFreeContext $basectx): JmespathFreeContext
    {
        return new JmespathFreeContext($ctxmap, $basectx);
    }
}
