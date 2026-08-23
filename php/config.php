<?php
declare(strict_types=1);

// JmespathFree SDK configuration

class JmespathFreeConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "JmespathFree",
                "slug" => "jmespath-free",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://noteapiconnector-tools.vercel.app/api",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "jmes_path" => [],
                ],
            ],
            "entity" => [
        'jmes_path' => [
          'fields' => [
            [
              'name' => 'data',
              'req' => true,
              'short' => 'The JSON object or array to transform',
              'type' => '`$ANY`',
              'union' => [
                'branches' => 2,
                'count' => 1,
                'depth' => 0,
              ],
            ],
            [
              'name' => 'query',
              'req' => true,
              'short' => 'The JMESPath expression string to evaluate against the data',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'jmes_path',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/jmespath',
                  'parts' => [
                    'jmespath',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return JmespathFreeFeatures::make_feature($name);
    }
}
