package com.example.time_tracking;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
        private static final String CHANNEL = "camera_activity";

        @Override
        public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
                super.configureFlutterEngine(flutterEngine);
                new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                        .setMethodCallHandler(
                                (call, result) -> {
                                        Log.i("HomeActivity", "oncreate");
                                        Log.i("HomeActivity", call.method);
                                        Intent intent = new Intent(this, CameraActivity.class);
                                        startActivity(intent);
                                       

                                }
                        );
        }
}