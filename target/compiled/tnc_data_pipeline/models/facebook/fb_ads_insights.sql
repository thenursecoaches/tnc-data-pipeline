



WITH fb_ads_insights as (

	    
		   	SELECT 
		   	account_name
		   	,'Paid' as channel
		   	,'Facebook Ads' as platform
		   	,"null" as campaign_advertising_channel_type
			,date_start
			,cast(campaign_id as INT64) campaign_id
			,campaign_name
			,adset_id
			,adset_name
			,ad_id
			,ad_name
			,spend
			,inline_link_click_ctr
			,impressions
			,inline_link_clicks
			##_sdc_sequence,
			##first_value(_sdc_sequence) OVER (PARTITION BY date_start, ad_id, campaign_id ORDER BY _sdc_sequence DESC) lv
			FROM `tnc-data-pipeline-347720.fb_thenursecoaches.ads_insights`
		    
	   

)

SELECT
account_name account
,date_start date
,channel
,platform
,campaign_advertising_channel_type
,campaign_id
,campaign_name campaign
,adset_id
,adset_name
,ad_id
,ad_name
,sum(spend) cost
,sum(impressions) impressions
,sum(inline_link_clicks) clicks
FROM fb_ads_insights

##where lv = _sdc_sequence
GROUP BY 
account
,date
,campaign_id
,campaign
,adset_id
,adset_name
,ad_id
,ad_name
,channel
,platform
,campaign_advertising_channel_type

