<?php
declare(strict_types=1);

// JmespathFree SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class JmespathFreeFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new JmespathFreeBaseFeature();
            case "test":
                return new JmespathFreeTestFeature();
            default:
                return new JmespathFreeBaseFeature();
        }
    }
}
