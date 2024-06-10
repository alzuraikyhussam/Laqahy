<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $post = Post::orderBy('post_publish_date', 'desc')->get();
            $postWithImageUrl = $post->map(function ($posts) {
                $posts->image_url = url('storage/images/' . $posts->post_image);
                return $posts;
            });

            return response()->json([
                'message' => 'Posts retrieved successfully',
                'data' => $postWithImageUrl,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {


        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'post_title' => 'required',
                    'post_description' => 'required',
                    'post_image' => 'required|image|mimes:png,jpg,jpeg',
                ],
            );
            // $request->validate([
            //     'post_title' => 'required',
            //     'post_description' => 'required',
            //     'post_image' => 'required|image|mimes:png,jpg,jpeg',
            // ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // Save image in storage/app/public
            $imageName = time() . '.' . $request->post_image->extension();
            $path = $request->post_image->storeAs('public/images', $imageName);

            // Create record
            $post = Post::create([
                'post_title' => $request->post_title,
                'post_description' => $request->post_description,
                'post_image' => $imageName,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Post created successfully',
                'data' =>
                [
                    'id' => $post->id,
                    'post_title' => $post->post_title,
                    'post_description' => $post->post_description,
                    'post_image' => url($post->post_image),
                    'post_publish_date' => $post->post_publish_date,
                ],
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        try {
            $post = Post::find($id);

            if (!$post) {
                return response()->json([
                    'message' => 'Post not found',
                ], 404);
            }

            $post->update($request->only(['post_title', 'post_description']));

            // التحقق من وجود ملف الصورة في الطلب
            if ($request->hasFile('post_image')) {
                // Delete previous image
                if ($post->post_image) {
                    Storage::delete('public/images/' . $post->post_image);
                }

                // Upload the new image
                $imageName = time() . '.' . $request->file('post_image')->extension();
                $path = $request->post_image->storeAs('public/images', $imageName);

                // Upload the new image
                // $image = $request->file('post_image');
                // $imageName = time() . '.' . $image->getClientOriginalExtension();
                // $image->move(public_path('images'), $imageName);

                // Update the post with the new image name
                $post->post_image = $imageName;
                $post->save();
            }


            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Post updated successfully',
                'data' =>
                [
                    'id' => $post->id,
                    'post_title' => $post->post_title,
                    'post_description' => $post->post_description,
                    'post_image' => url($post->post_image),
                    'post_publish_date' => $post->post_publish_date,
                ],
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $post = Post::find($id);
            if (!$post) {
                return response()->json(['message' => 'Post not found',], 404);
            }

            // if ($post->post_image) {
            // Delete previous image
            //     Storage::delete('public/images/' . $post->post_image);
            // }


            $post->delete();

            return response()->json(['message' => 'Post deleted successfully',], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function trashedPosts()
    {
        try {
            $trashedPosts = Post::onlyTrashed()->get();
            if ($trashedPosts) {
                $postWithImageUrl = $trashedPosts->map(function ($posts) {
                    $posts->image_url = url('storage/images/' . $posts->post_image);
                    return $posts;
                });
                return response()->json([
                    'message' => 'Posts retrieved successfully',
                    'data' => $postWithImageUrl,
                ]);
            }

            return response()->json(['message' => 'No soft deleted posts found.'], 404);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function forceDelete($id)
    {

        try {
            // Find the post with trashed (soft deleted) records included
            $post = Post::withTrashed()->find($id);

            if ($post && $post->trashed()) {


                // Delete image
                Storage::delete('public/images/' . $post->post_image);


                // Force delete the post
                $post->forceDelete();
                return response()->json(['message' => 'Post permanently deleted.'], 200);
            }

            return response()->json(['message' => 'Post not found or not deleted.'], 404);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function forceDeleteAll()
    {
        try {
            // Retrieve all soft deleted posts and force delete them
            $deletedCount = Post::onlyTrashed()->forceDelete();

            if ($deletedCount === 0) {
                return response()->json(['message' => 'No soft deleted posts found.'], 404);
            }

            // Delete image
            Storage::deleteDirectory('public/images');

            return response()->json(['message' => 'All soft deleted posts have been permanently deleted.'], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function restore($id)
    {
        try {
            // Find the post with trashed (soft deleted) records included
            $post = Post::withTrashed()->find($id);

            if ($post && $post->trashed()) {
                // Restore the post
                $post->restore();
                return response()->json(['message' => 'Post restored successfully.'], 200);
            }

            return response()->json(['message' => 'Post not found or not deleted.'], 404);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function restoreAll()
    {
        try {
            // Retrieve all soft deleted posts and restore them
            $restoredCount = Post::onlyTrashed()->restore();

            if ($restoredCount === 0) {
                return response()->json(['message' => 'No soft deleted posts found.'], 404);
            }

            return response()->json(['message' => 'All soft deleted posts have been restored.'], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
