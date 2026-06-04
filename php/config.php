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
              'type' => '`$ANY`',
              'active' => true,
              'index$' => 0,
            ],
            [
              'name' => 'query',
              'req' => true,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 1,
            ],
          ],
          'name' => 'jmes_path',
          'op' => [
            'create' => [
              'name' => 'create',
              'points' => [
                [
                  'method' => 'POST',
                  'orig' => '/jmespath',
                  'parts' => [
                    'jmespath',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'active' => true,
                  'args' => [],
                  'select' => [],
                  'index$' => 0,
                ],
              ],
              'input' => 'data',
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
