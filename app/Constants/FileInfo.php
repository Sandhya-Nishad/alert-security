<?php

namespace App\Constants;

class FileInfo
{

    /*
    |--------------------------------------------------------------------------
    | File Information
    |--------------------------------------------------------------------------
    |
    | This class basically contain the path of files and size of images.
    | All information are stored as an array. Developer will be able to access
    | this info as method and property using FileManager class.
    |
    */

    public function fileInfo()
    {
        $data['default'] = [
            'path'      => 'public/assets/images/default1.png',
        ];
        $data['extensions'] = [
            'path'      => 'public/assets/images/extensions',
            'size'      => '36x36',
        ];
        $data['logoIcon'] = [
            'path'      => 'public/assets/images/logo_icon',
        ];
        $data['favicon'] = [
            'size'      => '128x128',
        ];
        $data['adminProfile'] = [
            'path'      => 'public/assets/admin/images/profile',
            'size'      => '400x400',
        ];
        $data['product'] = [
            'path'      => 'public/assets/images/product',
            'size'      => '400x400',
        ];
        $data['customer'] = [
            'path' => 'public/assets/images/customer',
            'size' => '400x400',
        ];
        return $data;
    }
}
