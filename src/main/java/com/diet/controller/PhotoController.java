package com.diet.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.diet.entity.Photo;
import com.diet.service.PhotoService;

import org.springframework.core.io.ResourceLoader;

@RestController
@RequestMapping("/photo")

public class PhotoController {
	  @Autowired
	  PhotoService service;
	   
       public static String FILEPATH_IMAGE = "/var/www/html/";
       public static String SERVER_URL = "http://160.16.213.66/";
//       public static String SERVER_URL = "http://192.168.11.131/";
//      public static String filepath2 = "C:\\Users\\hoshi\\Documents\\workspace-sts-3.9.0.RELEASE\\db-sample\\src\\main\\webapp\\WEB-INF\\views\\images\\";	        
	  
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Photo> counterSelectAll() {
	    return service.selectAll(); 
	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public List<Photo> get(@RequestParam("week") String week,Model model, @PathVariable int id) {	
	  //public Advice get(@PathVariable int id) {
		List<Photo> photos = service.get(id, Integer.parseInt(week));
		for(Photo photo :photos) {
			photo.setUrl(SERVER_URL + photo.getUrl());
		}
	    return photos;
	  }
	  
	  
	  @RequestMapping(value="/delete",method=RequestMethod.POST)
	  public Photo del(@Validated @RequestBody List<Photo> photos) {
		for(Photo photo : photos) {
			Photo photo1 =  service.findOne(photo.getId());
			String filename = FILEPATH_IMAGE + photo1.getUrl();
		    File file = new File(filename);
		    if (file.exists()){
		      if (file.delete()){
		        System.out.println("ファイルを削除しました");
		      }
		    }
		    service.delete(photo.getId());
		}
		return new Photo();
	  }
	  
	    @RequestMapping(value="/upload", method = RequestMethod.POST)
	    public Object upload(
	            @RequestParam("upload_file") MultipartFile multipartFile,
	            @RequestParam("userid") Integer userid,
	            @RequestParam("week") Integer week
	            ){
	        // ファイルが空の場合は異常終了
	        if(multipartFile.isEmpty()){
	            // 異常終了時の処理
	        }
	        
	        
	        // ファイル種類から決まる値をセットする
//	        StringBuffer filePath = new StringBuffer("/uploadfile")
//	                                        .append(File.separator).append(fileType);   //ファイルパス

//	        StringBuffer filePath = new StringBuffer();
//	        filePath.append(filepath1);
//	        // アップロードファイルを格納するディレクトリを作成する
//	        File uploadDir = mkdirs(filePath);
	        Photo photo1 = new Photo();
	        Date now = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	        String[] strs = multipartFile.getOriginalFilename().split("\\.");
	        String ext = strs[strs.length - 1];
	        String filename = String.format("%03d_%03d_%s.%s", userid, week, sdf.format(now), ext);
	        try {
	            // アップロードファイルを置く
	            File uploadFile =
	                    new File(FILEPATH_IMAGE + filename);
	            byte[] bytes = multipartFile.getBytes();
	            BufferedOutputStream uploadFileStream =
	                    new BufferedOutputStream(new FileOutputStream(uploadFile));
	            uploadFileStream.write(bytes);
	            uploadFileStream.close();

//	            // アップロードファイルを置く
//	            uploadFile =
//	                    new File(filepath2 + filename);
//	            bytes = multipartFile.getBytes();
//	            uploadFileStream =
//	                    new BufferedOutputStream(new FileOutputStream(uploadFile));
//	            uploadFileStream.write(bytes);
//	            uploadFileStream.close();
	            
	            Photo photo = new Photo();
	            photo.setUserId(userid);
	            photo.setWeek(week);
//	            photo.setUrl("/images/" + filename);;
	            photo.setUrl(filename);;
	            photo1 = service.save(photo);
	            return photo1;
	        } catch (Exception e) {
	            // 異常終了時の処理
	        } catch (Throwable t) {
	            // 異常終了時の処理
	        } finally {
	        	return photo1;
	        }
	    }
	  
	    @RequestMapping(value="/upload1", method = RequestMethod.POST)
	    public Object upload1(
	            @RequestParam("upload_file") MultipartFile multipartFile,
	            @RequestParam("filetype") String fileType  // ファイル種類
	            ){
	        // ファイルが空の場合は異常終了
	        if(multipartFile.isEmpty()){
	            // 異常終了時の処理
	        }
	        
	        String filepath1 = "C:\\Users\\hoshi\\Documents\\workspace-sts-3.9.0.RELEASE\\db-sample\\src\\main\\resources\\static\\images\\";
	        
	        // ファイル種類から決まる値をセットする
//	        StringBuffer filePath = new StringBuffer("/uploadfile")
//	                                        .append(File.separator).append(fileType);   //ファイルパス

	        StringBuffer filePath = new StringBuffer();
	        filePath.append(filepath1);
	        // アップロードファイルを格納するディレクトリを作成する
	        File uploadDir = mkdirs(filePath);

	        try {
	            // アップロードファイルを置く
	            File uploadFile =
	                    new File(uploadDir.getPath() + "/" + fileType);
	            byte[] bytes = multipartFile.getBytes();
	            BufferedOutputStream uploadFileStream =
	                    new BufferedOutputStream(new FileOutputStream(uploadFile));
	            uploadFileStream.write(bytes);
	            uploadFileStream.close();
	            return "aa";
	        } catch (Exception e) {
	            // 異常終了時の処理
	        } catch (Throwable t) {
	            // 異常終了時の処理
	        } finally {
	        	return "end";
	        }
	    }

	    /**
	     * アップロードファイルを格納するディレクトリを作成する
	     *
	     * @param filePath
	     * @return
	     */
	    private File mkdirs(StringBuffer filePath){
	        Date now = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	        File uploadDir = new File(filePath.toString(), sdf.format(now));
	        // 既に存在する場合はプレフィックスをつける
	        int prefix = 0;
	        while(uploadDir.exists()){
	            prefix++;
	            uploadDir =
	                    new File(filePath.toString() + sdf.format(now) + "-" + String.valueOf(prefix));
	        }

	        // フォルダ作成
	        uploadDir.mkdirs();

	        return uploadDir;
	    }	  
}
