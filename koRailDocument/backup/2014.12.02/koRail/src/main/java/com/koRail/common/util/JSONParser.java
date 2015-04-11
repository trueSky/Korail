package com.koRail.common.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class JSONParser {
	private static JSONParser jsonParser;
	
	public static JSONParser getInstance(){
		if(jsonParser == null){
			return jsonParser = new JSONParser();
		}else{
			return jsonParser;
		}
	}
	
	/*************************************
	 * json을 bean으로 변환
	 * @param json
	 * @param getJSONName
	 * @param beanFullName
	 * @return
	 ************************************/
	public List<Object> processJSONToBean(String json, String getJSONName, String beanFullName) {
		try{
			/* 입력받은 클레스명(페키지 포함) */
			Class<?> className = Class.forName(beanFullName);
			/* bean을 담을 List */
			List<Object> beanList = new ArrayList<Object>();
			/* 빈으로 만들 JSON을 JSONArray로 변환 */
			JSONArray jsonArray = JSONObject.fromObject(json).getJSONArray(getJSONName);
			/* JSONArray의 정보들 */
			Iterator<?> iterator = jsonArray.iterator();
			 /*JSONArray의 값이 존재한다면 반복문 실행*/
			 while (iterator.hasNext()) {
				 /* JSON값들을 Bean으로 변환 후 beanList에 추가 */
				 beanList.add(JSONObject.toBean((JSONObject)iterator.next(), className));
			 }
			 
			 /*while (iterator.hasNext()) {
				JSONObject key = (JSONObject)iterator.next();
				
				for(Object val :  key.keySet()){
					String getter = "get"+StringUtils.capitalize(val.toString());
					String setter = "set"+StringUtils.capitalize(val.toString());
	
					if(className.getMethod(getter).getReturnType() == java.util.List.class){
						continue;
					}else{
						Method method = className.getDeclaredMethod(setter, new Class[]{String.class});
						method.invoke(instance, new Object[]{key.getString(val.toString())});  // 메서드 인자값 : Object[]{a,b,..}					
					}
				}
			}*/

			 return beanList;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
}
