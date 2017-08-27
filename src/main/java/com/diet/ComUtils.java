package com.diet;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ComUtils {
	  public  static int passweek(String startDate) throws ParseException {
	        Calendar c = Calendar.getInstance();
	        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
			String toDate = sdf1.format(c.getTime());
		    String strform = String.format("%s %s", startDate, "00:00:00");
		    String strto = String.format("%s %s", toDate, "00:00:00");
		    //日数の計算
		    Date frome1 = DateFormat.getDateInstance().parse(strform);
		    Calendar calFrom1 = Calendar.getInstance();
		    calFrom1.setTime(frome1);

		    Calendar calTo = Calendar.getInstance(); 
		    Date to1 = DateFormat.getDateInstance().parse(strto);
		    calTo.setTime(to1);

		    long diffTime = calTo.getTimeInMillis() - calFrom1.getTimeInMillis();
			long wpass = diffTime / ((1000 * 60 * 60 * 24)*7);
		  return (int)wpass;
	  }

}
