<?php
return [
    [
        'class' => 'SingleFileAppender',
        'threshold' => 1,
        'max_file_size' => 1048576,
        'rotation-ratio' => .5,
        'file' => dirname(__FILE__) . '/../../log/error.txt',
        'prefix' => '[dev]'
    ]
];