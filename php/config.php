<?php
declare(strict_types=1);

// JmespathFree SDK configuration

class JmespathFreeConfig
{
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "JmespathFree",
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
                "auth" => [
                    "prefix" => "Bearer",
                ],
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
              'active' => true,
              'name' => 'data',
              'req' => true,
              'type' => '`$ANY`',
              'index$' => 0,
            ],
            [
              'active' => true,
              'name' => 'query',
              'req' => true,
              'type' => '`$STRING`',
              'index$' => 1,
            ],
          ],
          'name' => 'jmes_path',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'active' => true,
                  'args' => [],
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
                  'index$' => 0,
                ],
              ],
              'key$' => 'create',
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
