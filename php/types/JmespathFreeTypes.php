<?php
declare(strict_types=1);

// Typed models for the JmespathFree SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** JmesPath entity data model. */
class JmesPath
{
    public mixed $data;
    public string $query;
}

/** Match filter for JmesPath#create (any subset of JmesPath fields). */
class JmesPathCreateData
{
    public mixed $data = null;
    public ?string $query = null;
}

