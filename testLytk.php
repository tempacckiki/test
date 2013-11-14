


<?php

?>
<div class="p_4"><span style="font-weight: bold; text-decoration: underline; font-size: 13px;">{phrase var='profilepopup.notice'}: </span>{phrase var='profilepopup.global_settings_info'}</div>

<script type="text/javascript">


function Publisher(){

  this.observers = [];

}

Publisher.prototype.attach = function(observer){

  this.observers.push(observer);

}

Publisher.prototype.detach = function(observer){

  var index = this.observers.indexOf(observer);
      if (index == -1)

  alert("Observer not found");

  else
      observers.splice(index, 1);

}

Publisher.prototype.deliver = function(content){

  for(var i = 0; i < this.observers.length; i++){

  this.observers[i]. receive(content);
  

  }
}



function Person(name){

  this.name = name;

}

Person.prototype. subscribe = function(publisher){

   publisher.attach(this);

}

Person.prototype.receive = function(content){

   console.log(this.name + ' just read ' + content);

}

var NewYorkTimes = new Publisher();

var AustinHerald = new Publisher();

var SfChronicle = new Publisher();

var John = new Person('John');

var Lindsay = new Person('Lindsay');
var Quadaras = new Person('Quadaras');



John.subscribe(NewYorkTimes);

John.subscribe(SfChronicle);

Lindsay.subscribe(AustinHerald);

Lindsay.subscribe(SfChronicle);

Lindsay.subscribe(NewYorkTimes);

Quadaras.subscribe(AustinHerald);

Quadaras.subscribe(SfChronicle);

NewYorkTimes.deliver('Here is your paper! Direct from the Big apple');

AustinHerald.deliver('News');

AustinHerald.deliver('Reviews');

var var1 = 'test';

AustinHerald.deliver('Coupons');

SfChronicle.deliver('The weather is still chilly');
SfChronicle.deliver('Hi Mom! I\'m writing a book');


</script>



	
	
192.168.11.228
	
	
<?php
	
	public function globalUnionSearch($sSearch)
	{
		$this->database()->select('item.blog_id AS item_id, item.title AS item_title
					, item.time_stamp AS item_time_stamp, item.user_id AS item_user_id
					, \'blog\' AS item_type_id, \'\' AS item_photo, \'\' AS item_photo_server')
			->from(Phpfox::getT('blog'), 'item')
			->where($this->database()->searchKeywords('item.title', $sSearch) . ' AND item.is_approved = 1 AND item.privacy = 0 AND item.post_status = 1')
			->union();
	}	
	
	
public function getSearchInfo($aRow)
	{
		$aInfo = array();
		$aInfo['item_link'] = Phpfox::getLib('url')->permalink('blog', $aRow['item_id'], $aRow['item_title']);
		$aInfo['item_name'] = Phpfox::getPhrase('blog.blog');
		
		return $aInfo;
	}	
	
	
public function getSearchTitleInfo()
	{
		return array(
			'name' => Phpfox::getPhrase('blog.blog')
		);
	}	
	
	
	public function globalSearch($sQuery, $bIsTagSearch = false)
	{
		(($sPlugin = Phpfox_Plugin::get('blog.component_service_callback_globalsearch__start')) ? eval($sPlugin) : false);
		$sCondition = 'b.is_approved = 1 AND b.privacy = 1 AND b.post_status = 1';
		if ($bIsTagSearch == false)
		{
			$sCondition .= ' AND (b.title LIKE \'%' . $this->database()->escape($sQuery) . '%\' OR bt.text_parsed LIKE \'%' . $this->database()->escape($sQuery) . '%\')';
		}		
		
		if ($bIsTagSearch == true)
		{
			$this->database()->innerJoin(Phpfox::getT('tag'), 'tag', 'tag.item_id = b.blog_id AND tag.category_id = \'blog\' AND tag.tag_url = \'' . $this->database()->escape($sQuery) . '\'');
		}				
		
		$iCnt = $this->database()->select('COUNT(*)')
			->from($this->_sTable, 'b')
			->join(Phpfox::getT('blog_text'), 'bt', 'bt.blog_id = b.blog_id')
			->where($sCondition)
			->execute('getSlaveField');		
			
		if ($bIsTagSearch == true)
		{
			$this->database()->innerJoin(Phpfox::getT('tag'), 'tag', 'tag.item_id = b.blog_id AND tag.category_id = \'blog\' AND tag.tag_url = \'' . $this->database()->escape($sQuery) . '\'')->group('b.blog_id');
		}			
		
		$aRows = $this->database()->select('b.title, b.title_url, b.time_stamp, ' . Phpfox::getUserField())
			->from($this->_sTable, 'b')
			->join(Phpfox::getT('blog_text'), 'bt', 'bt.blog_id = b.blog_id')
			->join(Phpfox::getT('user'), 'u', 'u.user_id = b.user_id')
			->where($sCondition)
			->limit(10)
			->order('b.time_stamp DESC')
			->execute('getSlaveRows');
			
		if (count($aRows))
		{
			$aResults = array();
			$aResults['total'] = $iCnt;
			$aResults['menu'] = Phpfox::getPhrase('blog.search_blogs');
			
			if ($bIsTagSearch == true)
			{
				$aResults['form'] = '<div><input type="button" value="' . Phpfox::getPhrase('blog.view_more_blogs') . '" class="search_button" onclick="window.location.href = \'' . Phpfox::getLib('url')->makeUrl('blog', array('tag', $sQuery)) . '\';" /></div>';
			}
			else 
			{				
				$aResults['form'] = '<form method="post" action="' . Phpfox::getLib('url')->makeUrl('blog') . '"><div><input type="hidden" name="' . Phpfox::getTokenName() . '[security_token]" value="' . Phpfox::getService('log.session')->getToken() . '" /></div><div><input name="search[search]" value="' . Phpfox::getLib('parse.output')->clean($sQuery) . '" size="20" type="hidden" /></div><div><input type="submit" name="search[submit]" value="' . Phpfox::getPhrase('blog.view_more_blogs') . '" class="search_button" /></div></form>';
			}
			
			foreach ($aRows as $iKey => $aRow)
			{
				$aResults['results'][$iKey] = array(				
					'title' => $aRow['title'],	
					'link' => Phpfox::getLib('url')->makeUrl($aRow['user_name'], array('blog', $aRow['title_url'])),
					'image' => Phpfox::getLib('image.helper')->display(array(
							'server_id' => $aRow['server_id'],
							'title' => $aRow['full_name'],
							'path' => 'core.url_user',
							'file' => $aRow['user_image'],
							'suffix' => '_75',
							'max_width' => 75,
							'max_height' => 75
						)
					),
					'extra_info' => Phpfox::getPhrase('blog.blog_created_on_time_stamp_by_full_name', array(
							'link' => Phpfox::getLib('url')->makeUrl('blog'),
							'time_stamp' => Phpfox::getTime(Phpfox::getParam('core.global_update_time'), $aRow['time_stamp']),
							'user_link' => Phpfox::getLib('url')->makeUrl($aRow['user_name']),
							'full_name' => $aRow['full_name']	
						)
					)			
				);
			}
			(($sPlugin = Phpfox_Plugin::get('blog.component_service_callback_globalsearch__return')) ? eval($sPlugin) : false);
			return $aResults;
		}
		(($sPlugin = Phpfox_Plugin::get('blog.component_service_callback_globalsearch__end')) ? eval($sPlugin) : false);
	}	
	
	public function getNewsItems($aConds = array(), $iPage = 0, $iPageSize = null, $iCount = null, $sOrder = null, $sMode = '')
	{
		if($sMode == "admincp")
		{
			$sSelectFields = "ni.item_id, ni.item_title, ni.is_active, ni.item_image, ni.server_id as item_server_id, ni.item_pubDate, ni.item_pubDate_parse, ni.added_time, ni.is_approved, ni.is_featured, nf.feed_id, nf.feed_name";
		} 
		else
		{
			$sSelectFields ="ni.item_id, ni.item_title, ni.item_alias, ni.item_image, ni.server_id as item_server_id, ni.item_author,  ni.item_description_parse, ni.item_content_parse, ni.item_pubDate, ni.item_pubDate_parse, ni.added_time, ni.total_view, ni.total_comment, ni.total_favorite";
		}
		// Generate query object		
		$oQuery = $this	-> database() 
						-> select($sSelectFields)
						-> from(Phpfox::getT('ynnews_items'), 'ni ')
						-> join(Phpfox::getT('ynnews_feeds'),'nf', 'nf.feed_id = ni.feed_id');
						
		// Filter select condition
		if($aConds)
		{
			$oQuery->where($aConds);
		}
		
		// Setup select ordering		
		if($sOrder)
		{
			$oQuery->order($sOrder);
		}				
		
		// Setup limit items getting
		$oQuery->limit($iPage, $iPageSize, $iCount);
		$aNewsItems = $oQuery->execute('getRows');
        
        foreach ($aNewsItems as $k => $aNews)
        {
            if (isset($aNews['item_image']) && Phpfox::getParam('core.allow_cdn') && $aNews['item_server_id'] > 0)
            {
                $aNewsItems[$k]['item_image'] = Phpfox::getLib('cdn')->getUrl($aNews['item_image'], $aNews['item_server_id']);
            }
        }
        
	 	return $aNewsItems;
	}
	
	

?>
	
	
	
oxwall152: 
fb: 
515897465140052
5595cf78b1b014f861a44c3297b72a05

twitter: 
ltXgZKH2nSgHZNVru6GYg
k9IkuPVzZimMDj66762KWeCXjCq5e4MIxidcLWHcM

linkedin: 
74es7ocrbbc3
Y3Ms0q3yz0Sh65zS


192.168.11.226
lytk.dev3
/home/dev3/public_html/phpfox/lytk/phpfox360dev/



192.168.7.157
255.255.255.0
192.168.7.1

8.8.8.8


<script type="text/javascript">
var music_redict_url = "http://friend7.com/musicsharing/upload/album_93/";
$oSWF_settings =
{
	object_holder: function()
	{
		return 'swf_msf_upload_button_holder';
	},
	div_holder: function()
	{
		return 'swf_msf_upload_button';
	},
	get_settings: function()
	{
		console.log(swfu);
		swfu.setUploadURL("http://friend7.com/musicsharing/up/");
		swfu.setFileTypes("*.mp3","MP3 Music Files");
		swfu.setFileSizeLimit("30723276.8 B");
		swfu.setFileUploadLimit(10);
		swfu.setFileQueueLimit(10);
		swfu.customSettings.flash_user_id = 2;
		swfu.customSettings.sHash = "66f69c6dddfc20524db5a8bcf1c42671";
		swfu.customSettings.sAjaxCall = "musicsharing.uploadProcess";
		swfu.customSettings.sAjaxCallAction = function(){
			tb_show('', '', null, 'Please hold while your files are being processed.');
		};
		swfu.atFileQueue = function()
		{
			$('#js_msf_form :input').each(function(iKey, oObject)
			{
				swfu.addPostParam($(oObject).attr('name'), $(oObject).val());
			});
		}
	}
}
</script>




    /* If the browser does not support Navigator we can get the latitude and longitude using the IPInfoDBKey */
    sIPInfoDbKey: '',
    /* Google requires the key to be passed so we store it here*/
    sGoogleKey : '',
    /* Google object holding my location*/
    gMyLatLng : undefined,
    bGoogleReady: false,
    /* This is the google map object, we can control the map from this variable */
    gMap : undefined,
    /* The id of the div that will display the map of the current location */
    sMapId : 'js_feed_check_in_map',
    /* Google's marker in the map */
    gMarker: undefined,
    /* Here we store the places gotten from Google and Pages. This array is reset as the user moves away from the found place */
    aPlaces : [],
	
	
ga_status_code_error
Phpfox::getPhrase('mobiletemplate.ga_status_code_error')

ga_status_code_invalid_request
Phpfox::getPhrase('mobiletemplate.ga_status_code_invalid_request')

ga_status_code_over_query_limit
Phpfox::getPhrase('mobiletemplate.ga_status_code_over_query_limit')

ga_status_code_request_denied
Phpfox::getPhrase('mobiletemplate.ga_status_code_request_denied')

ga_status_code_unknown_error
Phpfox::getPhrase('mobiletemplate.ga_status_code_unknown_error')

ga_status_code_zero_results
Phpfox::getPhrase('mobiletemplate.ga_status_code_zero_results')




near by search: 
name
	"Tân Thới Nhất"
id
	"a48bc25c087f31e499c331eaadb34cfca4e18d74"
vicinity
	"Tân Thới Nhất"
icon
	"http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png"

text search: 
formatted_address
	"Thống Nhất, Gò Vấp, Ho Chi Minh City, Vietnam"
icon
	"http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png"
name
	"Thống Nhất"
id
	"b745474897f90dcb82c980874770a7553052f238"
	
	
compare: 	
C:\Users\lytk\Desktop\phpfox-product-brodev_better_mobile-2.7-Nulled by ainab\upload\module\feed\template\bettermobile\block
C:\Users\lytk\Desktop\phpfox360b3\module\feed\template\default\block

mysqldump -u qc -pqc123 qc_phpfox360b3_hx>/home/xuannh/qc/xuannth/lytk/qc_phpfox360b3_hx.sql



--------------------------------------------------------------

https://s3-us-west-1.amazonaws.com/citizens/file/pic/advancedmarketplace/2013/08/903e0937e87bdd62ac28bc7c4d87d04c_120.png
https://s3-us-west-1.amazonaws.com/citizens/file/pic/foxfeedspro/2013/08/428226dbe496b77cfddbe06e334466d9.jpg




{img server_id=$aListing.server_id title=$aListing.title path='advancedmarketplace.url_pic' file=$aListing.image_path suffix='' max_width='520' max_height='322'}
{img server_id=$aAlbum.server_id path='music.url_image' file=$aAlbum.image_path suffix='_50_square' max_width='50' max_height='50'}



array(6) {
  ["server_id"]=>
  string(1) "1"
  ["path"]=>
  string(15) "music.url_image"
  ["file"]=>
  string(46) "2013/08/54815906a0a712a9c19c665bfd671c7b%s.jpg"
  ["suffix"]=>
  string(10) "_50_square"
  ["max_width"]=>
  string(2) "50"
  ["max_height"]=>
  string(2) "50"
}




 array(7) {   
 ["server_id"]=>   string(1) "1"   [
 "path"]=>   string(27) "advancedmarketplace.url_pic"   
 ["file"]=>   string(46) "2013/08/903e0937e87bdd62ac28bc7c4d87d04c%s.png"   
 ["suffix"]=>   string(4) "_120"   
 ["max_width"]=>   int(120)   
 ["max_height"]=>   int(90)   
 ["title"]=>   string(5) "House" } 
 
 
 
 
<ul class="ym-feed-link">

<li class="li_action">
	<a href="#" onclick="alert('more more'); return false;" class="js_like_link_toggle js_like_link_like">
		<i class="icon-like"></i>More More	</a>
</li>

</ul>