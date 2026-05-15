<?php
declare(strict_types=1);

// JmespathFree SDK exists test

require_once __DIR__ . '/../jmespathfree_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = JmespathFreeSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
