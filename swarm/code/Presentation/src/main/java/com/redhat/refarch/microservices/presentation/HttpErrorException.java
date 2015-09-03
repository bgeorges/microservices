package com.redhat.refarch.microservices.presentation;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.util.EntityUtils;

public class HttpErrorException extends Exception
{

	private static final long serialVersionUID = 1L;
	private int code;
	private String content;

	public HttpErrorException(HttpResponse response)
	{
		code = response.getStatusLine().getStatusCode();
		try
		{
			content = EntityUtils.toString( response.getEntity() );
		}
		catch( ParseException | IOException e )
		{
			content = "Unknown";
		}
	}

	@Override
	public String getMessage()
	{
		return "HTTP Error " + code + ": " + content;
	}
}