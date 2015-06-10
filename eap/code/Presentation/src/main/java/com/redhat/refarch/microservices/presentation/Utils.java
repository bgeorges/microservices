package com.redhat.refarch.microservices.presentation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

public class Utils
{

	public static List<Map<String, Object>> getList(JSONArray jsonArray) throws JSONException
	{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for( int index = 0; index < jsonArray.length(); index++ )
		{
			Map<String, Object> map = new HashMap<String, Object>();
			JSONObject jsonObject = jsonArray.getJSONObject( index );
			for( Iterator<?> jsonIterator = jsonObject.keys(); jsonIterator.hasNext(); )
			{
				String jsonKey = (String)jsonIterator.next();
				map.put( jsonKey, jsonObject.get( jsonKey ) );
			}
			list.add( map );
		}
		return list;
	}

	public static JSONObject getJsonObject(HttpServletRequest request, String... params) throws JSONException
	{
		JSONObject jsonObject = new JSONObject();
		for( String attribute : params )
		{
			String value = request.getParameter( attribute );
			jsonObject.put( attribute, value );
		}
		return jsonObject;
	}

	public static Map<String, Object> getCustomer(JSONObject jsonObject) throws JSONException
	{
		Map<String, Object> customer = new HashMap<String, Object>();
		customer.put( "name", jsonObject.getString( "name" ) );
		customer.put( "address", jsonObject.getString( "address" ) );
		customer.put( "telephone", jsonObject.getString( "telephone" ) );
		customer.put( "id", jsonObject.getLong( "id" ) );
		return customer;
	}
}