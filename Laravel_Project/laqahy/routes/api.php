<?php

use App\Http\Controllers\PostController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// --------------------- Post Routes ------------------------
Route::get('posts/trashed', [PostController::class, 'trashedPosts']);
Route::delete('posts/force-delete/{id}', [PostController::class, 'forceDelete']);
Route::delete('posts/force-delete-all', [PostController::class, 'forceDeleteAll']);
Route::patch('posts/restore/{id}', [PostController::class, 'restore']);
Route::patch('posts/restore-all', [PostController::class, 'restoreAll']);
Route::post('posts/add-post', [PostController::class, 'store']);
Route::get('posts', [PostController::class, 'index']);
Route::patch('posts/update-post/{id}', [PostController::class, 'update']);
Route::delete('posts/delete-post/{id}', [PostController::class, 'destroy']);
// ------------------------------------------------------------