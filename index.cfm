<cfprocessingdirective pageEncoding = "UTF-8">

<cfset _exec()>
<!---===============================
_exec
================================--->
<cffunction	name="_exec" returnType="void" output="yes">
	<cfset var local = structNew()>

	<cfset _init()>

	<!--- 処理 --->
	<cfswitch expression = "#form.sts#">
		<!--- 検索 --->
		<cfcase value="srch">
			<!--- クッキー保存 --->
			<cfloop index="local.idx" list="#request.listFld#">
				<cfcookie name="#local.idx#" value="#form[local.idx]#" expires="never">
			</cfloop>

			<!--- txbizのコンテンツ取得 --->
			<cfhttp url="http://txbiz.tv-tokyo.co.jp//search/" method="post" resolveURL="yes">
				<cfloop index="local.idx" list="#request.listFld#">
					<cfhttpparam type="formField" name="#local.idx#" value="#form[local.idx]#">
				</cfloop>
			</cfhttp>
			<cfoutput>#cfhttp.fileContent#</cfoutput>
			<cfabort>
		</cfcase>
	</cfswitch>

	<!--- cookieがあったときはformにデータセット --->
	<cfloop index="local.idx" list="#request.listFld#">
		<cfif isDefined("cookie.#local.idx#")>
			<cfset form[local.idx]= cookie[local.idx]>
		</cfif>
	</cfloop>

	<cfset _dsp()>
</cffunction>
<!---===============================
_init
================================--->
<cffunction	name="_init" returnType="void" output="no">
	<cfset var local = structNew()>

	<cfset request.listFld = "word,genre,category,wbs,nms,mplus11,mplusex,gaia,cambria,zipangu,kikan,calendar_from,calendar_to,search_select">
	<cfparam name="form.word"			default="">
	<cfparam name="form.genre"			default="">
	<cfparam name="form.category"		default="">
	<cfparam name="form.wbs"			default="">
	<cfparam name="form.nms"			default="">
	<cfparam name="form.mplus11"		default="">
	<cfparam name="form.mplusex"		default="">
	<cfparam name="form.gaia"			default="">
	<cfparam name="form.cambria"		default="">
	<cfparam name="form.zipangu"		default="">
	<cfparam name="form.kikan"			default="30">
	<cfparam name="form.calendar_from"	default="">
	<cfparam name="form.calendar_to"	default="#dateformat(now(),'yyyy/mm/dd')#">
	<cfparam name="form.search_select"	default="sort_score">
	<cfparam name="form.sts"			default="">		<!--- このプログラムの処理用 --->
</cffunction>
<!---===============================
_dsp
================================--->
<cffunction	name="_dsp" returnType="void" output="yes">
	<cfoutput>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
	<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-type" content="text/css; charset=utf-8" />
	<meta http-equiv="content-type" content="text/JavaScript; charset=utf-8" />
	<meta http-equiv="content-language" content="ja" />
	<meta name="ROBOTS" name="ALL" />

	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />

	<title>「テレビ東京ビジネスオンデマンド」の検索条件</title>

	<meta name="description" content="「テレビ東京ビジネスオンデマンド」では検索条件が毎回クリアされているので、サイト管理人が便利に使えるようにちょっと作ってみました。"/>
	<meta name="keywords" content="テレビ東京,経済,ビジネスオンデマンド,TX,TVTOKYO,ワールドビジネスサテライト,Newsモーニングサテライト,Mプラス,MプラスEx,日経スペシャル ガイアの夜明け,日経スペシャル カンブリア宮殿,日経スペシャル 未来世紀ジパング ～沸騰現場の経済学～"/>

	<body>

	<h1>「テレビ東京ビジネスオンデマンド」の検索</h1>

	<p>テレビ局ではテレビ東京の視聴率が高い管理人が作りました。詳しくはこちら。</p>


	<form name="frm" action="#cgi.script_name#" target="txbiz" method="post">
	<table>
		<tr>
			<td>検索ワード</td>
			<td>
				<input type="text" name="word" value="#form.word#">
			</td>

			<td>ジャンル</td>
			<td>
				<select name="genre">
				<option value="">全て</option>
				<option value="1" <cfif form.genre eq "1">selected</cfif>>政治</option>
				<option value="2" <cfif form.genre eq "2">selected</cfif>>経済(マクロ・政策・インフラ整備)</option>
				<option value="3" <cfif form.genre eq "3">selected</cfif>>企業</option>
				<option value="4" <cfif form.genre eq "4">selected</cfif>>マーケット</option>
				<option value="5" <cfif form.genre eq "5">selected</cfif>>くらし・トレンド</option>
				<option value="6" <cfif form.genre eq "6">selected</cfif>>テクノロジー・科学</option>
				<option value="7" <cfif form.genre eq "7">selected</cfif>>国際</option>
				<option value="8" <cfif form.genre eq "8">selected</cfif>>社会-警察・検察</option>
				<option value="9" <cfif form.genre eq "9">selected</cfif>>社会-その他</option>
				</select>
			</td>

			<td>業種</td>
			<td>
				<select name="category">
				<option value="">全て</option>
				<option value= "1" <cfif form.category eq  "1">selected</cfif>>農林水産業</option>
				<option value= "2" <cfif form.category eq  "2">selected</cfif>>住宅・不動産・建設</option>
				<option value= "3" <cfif form.category eq  "3">selected</cfif>>食品・飲料</option>
				<option value= "4" <cfif form.category eq  "4">selected</cfif>>日用品・化粧品</option>
				<option value= "5" <cfif form.category eq  "5">selected</cfif>>機械・素材・エネルギー</option>
				<option value= "6" <cfif form.category eq  "6">selected</cfif>>医薬・医療</option>
				<option value= "7" <cfif form.category eq  "7">selected</cfif>>電機・家電メーカー（家電、デジカメ、携帯端末など）</option>
				<option value= "8" <cfif form.category eq  "8">selected</cfif>>自動車</option>
				<option value= "9" <cfif form.category eq  "9">selected</cfif>>流通・小売り・アパレル</option>
				<option value="10" <cfif form.category eq "10">selected</cfif>>外食・中食</option>
				<option value="11" <cfif form.category eq "11">selected</cfif>>輸送（航空・鉄道・宅配・倉庫など）</option>
				<option value="12" <cfif form.category eq "12">selected</cfif>>金融（銀行・証券・保険）</option>
				<option value="13" <cfif form.category eq "13">selected</cfif>>情報通信・メディア（通信キャリア・インターネット・ゲーム・ＳＮＳ・コンテンツ）</option>
				<option value="14" <cfif form.category eq "14">selected</cfif>>ホテル・レジャー・教育・その他サービス</option>
				<option value="15" <cfif form.category eq "15">selected</cfif>>該当なし</option>
				</select>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<td>番組指定</td>
			<td>
				<input type="checkbox" name="wbs" value="1"		<cfif form.wbs eq "1">checked</cfif>>ワールドビジネスサテライト
				<input type="checkbox" name="nms" value="1"		<cfif form.nms eq "1">checked</cfif>>モーニングサテライト
				<input type="checkbox" name="mplus11" value="1"	<cfif form.mplus11 eq "1">checked</cfif>>Mプラス
				<input type="checkbox" name="mplusex" value="1"	<cfif form.mplusex eq "1">checked</cfif>>MプラスEx
				<input type="checkbox" name="gaia" value="1"	<cfif form.gaia eq "1">checked</cfif>>ガイアの夜明け
				<input type="checkbox" name="cambria" value="1"	<cfif form.cambria eq "1">checked</cfif>>カンブリア宮殿
				<input type="checkbox" name="zipangu" value="1"	<cfif form.zipangu eq "1">checked</cfif>>未来世紀ジパング
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<td valign="top">期間指定</td>
			<td>
				<input type="radio" name="kikan" value="7"		<cfif form.kikan eq "7">checked</cfif>><label>1週間</label>
				<input type="radio" name="kikan" value="30"		<cfif form.kikan eq "30">checked</cfif>><label>1カ月</label>
				<input type="radio" name="kikan" value="90"		<cfif form.kikan eq "90">checked</cfif>><label>3カ月</label>
				<input type="radio" name="kikan" value="180"	<cfif form.kikan eq "180">checked</cfif>><label>6カ月</label>
				<input type="radio" name="kikan" value="365"	<cfif form.kikan eq "365">checked</cfif>><label>1年</label>
				<input type="radio" name="kikan" value="0"		<cfif form.kikan eq "0">checked</cfif>><label>全期間</label>

				<br>

				<input type="radio" name="kikan" value="calendar_term"		<cfif form.kikan eq "calendar_term">checked</cfif>>
				<input type="text" name="calendar_from"	value="#form.calendar_from#">-
				<input type="text" name="calendar_to"	value="#form.calendar_to#">(yyyy/mm/dd形式)
			</td>
		</tr>
		<tr>
			<td valign="top">表示順</td>
			<td>
				<input type="radio" name="search_select" value="sort_score"	<cfif form.search_select eq "sort_score">checked</cfif>><label>関連順</label>

				<br>

				<input type="radio" name="search_select" value="sort_new"	<cfif form.search_select eq "sort_new">checked</cfif>><label>最新順（放送日）</label>
			</td>
		</tr>
	</table>
	<input type="button" value="検索" onClick="js_submit('srch')">

	<input type="hidden" name="sts" value="">
	</form>

	<script type="text/javascript">
	<!--
	function js_submit(pSTS) {
		document.frm.sts.value = pSTS;
		document.frm.submit();
	}
	//-->
	</script>

	</body>
	</html>
	</cfoutput>
</cffunction>
