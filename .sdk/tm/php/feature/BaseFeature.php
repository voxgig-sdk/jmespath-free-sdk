<?php
declare(strict_types=1);

// JmespathFree SDK base feature

class JmespathFreeBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(JmespathFreeContext $ctx, array $options): void {}
    public function PostConstruct(JmespathFreeContext $ctx): void {}
    public function PostConstructEntity(JmespathFreeContext $ctx): void {}
    public function SetData(JmespathFreeContext $ctx): void {}
    public function GetData(JmespathFreeContext $ctx): void {}
    public function GetMatch(JmespathFreeContext $ctx): void {}
    public function SetMatch(JmespathFreeContext $ctx): void {}
    public function PrePoint(JmespathFreeContext $ctx): void {}
    public function PreSpec(JmespathFreeContext $ctx): void {}
    public function PreRequest(JmespathFreeContext $ctx): void {}
    public function PreResponse(JmespathFreeContext $ctx): void {}
    public function PreResult(JmespathFreeContext $ctx): void {}
    public function PreDone(JmespathFreeContext $ctx): void {}
    public function PreUnexpected(JmespathFreeContext $ctx): void {}
}
