package com.example.blog.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 「/gacha」のURLでこのサーブレットが呼び出されるように指定
@WebServlet("/gacha")
public class GachaServlet extends HttpServlet {

    // 各レアリティの表示出力
    private static final String SSR = "SSRモンスター!";
    private static final String SR = "SRモンスター";
    private static final String R = "Rモンスター";
    private static final String N = "Nモンスター";

    // ガチャの確率テーブル (100マスの中にレアリティごとの割合を設定)
    private static final String[] PROB_TABLE;

    //ランダムな数字を生成するためのインスタンス
    private Random rand = new Random();

    // 各レアリティの出現範囲の設定
    static {
        PROB_TABLE = new String[100];
        Arrays.fill(PROB_TABLE, 0, 5, SSR); // SSR → 5%
        Arrays.fill(PROB_TABLE, 6, 20, SR); // SR → 15%
        Arrays.fill(PROB_TABLE, 21, 50, R); // R → 30%
        Arrays.fill(PROB_TABLE, 51, 100, N); // N → 50%
    }

    // 単発ガチャの処理
    private String singleGacha() {
        int index = rand.nextInt(100); // 乱数抽選
        String result = PROB_TABLE[index]; // 該当するレアリティの取得

        // エラー処理 (null対策) しないとNullPointerExceptionのエラー
        if (result == null) {
            return N; // 何か適当な値を返す
        }
        return result;
    }

    // 10連ガチャの処理（単発ガチャを10回繰り返す）
    private String[] tenGacha() {
        String[] results = new String[10];
        for (int i = 0; i < 10; i++) {
            results[i] = singleGacha();
        }
        return results;
    }

    // HTTP GETリクエストの処理（ガチャ結果をjspに渡す）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // リクエストパラメーターから「single」または「ten」を取得
        String action = request.getParameter("action");
        String[] results;

        // 単発 or 10連のどちらかを判定してガチャを実行
        if ("single".equals(action)) {
            results = new String[]{ singleGacha() }; // 単発ガチャ
        } else {
            results = tenGacha(); // 10連ガチャ
        }

        // 結果をリクエスト属性に設定してjspに送信
        request.setAttribute("gachaResults", results);
        request.getRequestDispatcher("/jsp/gacha.jsp").forward(request, response);
    }
}
