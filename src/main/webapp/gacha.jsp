<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <% String[] results=(String[]) request.getAttribute("gachaResults"); int ssrCount=0, srCount=0, rCount=0, nCount=0;
        if (results !=null) { for (String item : results) { if (item.contains("SSR")) ssrCount++; else if
        (item.contains("SR")) srCount++; else if (item.contains("R")) rCount++; else if (item.contains("N")) nCount++; }
        } %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>ガチャシミュレーター</title>
            <style>
                .gacha-results {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 15px;
                }

                .gacha-results .item {
                    width: calc(33.33% - 10px);
                    /* 3個横並び */
                    text-align: center;
                }

                .gacha-button {
                    padding: 10px 20px;
                    font-size: 18px;
                }

                .result {
                    font-size: 20px;
                    margin-top: 20px;
                }

                .ssr {
                    color: red;
                    font-weight: bold;
                }

                .sr {
                    color: orange;
                    font-weight: bold;
                }

                .r {
                    color: gray;
                }

                .n {
                    color: green;
                }

                ul {
                    list-style-type: none;
                }
            </style>
        </head>

        <body>
            <h1>ガチャシミュレーター</h1>
            <div>
                <form method="get" action="${pageContext.request.contextPath}/gacha">
                    <input type="submit" class="gacha-button" name="action" value="single">
                    <input type="submit" class="gacha-button" name="action" value="ten">
                </form>
            </div>

            <div class="result">
                <% if (results !=null && results.length> 0) {
                    if (results.length == 1) {
                    // 単発
                    String item = results[0];
                    String cssClass = item.contains("SSR") ? "ssr" :
                    item.contains("SR") ? "sr" :
                    item.contains("R") ? "r" : "n";
                    String imgName = "";
                    if (item.contains("SSR")) imgName = "SSRcard.png";
                    else if (item.contains("SR")) imgName = "SRcard.png";
                    else if (item.contains("R")) imgName = "Rcard.png";
                    else imgName = "Ncard.png";

                    out.println("単発結果: <span class='" + cssClass + "'>" + item + "</span><br>");
                    out.println("<img src='" + request.getContextPath() + "/images/" + imgName + "' alt='" + item + "'style='width:150px;'>");
                    } else {

                    out.println("10連結果:<ul>");
                    out.println("<div class='gacha-results'>");
                        for (String item : results) {
                        String cssClass = item.contains("SSR") ? "ssr" :
                        item.contains("SR") ? "sr" :
                        item.contains("R") ? "r" : "n";
                        String imgName = "";
                        if (item.contains("SSR")) imgName = "SSRcard.png";
                        else if (item.contains("SR")) imgName = "SRcard.png";
                        else if (item.contains("R")) imgName = "Rcard.png";
                        else imgName = "Ncard.png";

                        out.println("<div class='item " + cssClass + "'>");
                            out.println(item + "<br>");
                            out.println("<img src='" + request.getContextPath() + "/images/" + imgName + "'alt='" + item + "' style='width:100px;'>");
                            out.println("</div>");
                        }
                        out.println("</div>");
                    }
                    out.println("<div>【結果まとめ】 SSR: " + ssrCount + " / SR: " + srCount +
                        " / R: " + rCount + " / N: " + nCount + "</div>");
                    }
                    %>

            </div>
        </body>

        </html>