package com.diet.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.diet.entity.Counter;
import com.diet.service.CounterService;

 
@RestController
@RequestMapping("/counter")
public class Controller {
   
  @Autowired
  CounterService service;

  @RequestMapping(value="/test",method=RequestMethod.POST)
  public Counter test(@Validated @RequestBody Counter counter) {
      return service.save(counter);
  }
   
  // 一覧表示
  @RequestMapping(value="/selectall", method=RequestMethod.GET)
  public List<Counter> counterSelectAll() {
    return service.selectAll(); 
  }
  @RequestMapping(value = "{id}", method = RequestMethod.GET)
  public Counter get(@PathVariable int id) {
    return service.get(id);
  }
  @RequestMapping(value="/save",method=RequestMethod.POST)
  public Counter createUser(@Validated @RequestBody Counter counter) {
      return service.save(counter);
  }
  @RequestMapping(value = "{id}", method = RequestMethod.DELETE)
  public void delete(@PathVariable int id) {
    service.delete(id);
  }
  
  @RequestMapping(path = "/upload", method = RequestMethod.POST)
  public void upload(InputStream req) throws IOException {

      ByteArrayOutputStream byteos = new ByteArrayOutputStream();
      byte[] buf = new byte[1024];
      int size = 0;
      while ((size = req.read(buf, 0, buf.length)) != -1) {
          byteos.write(buf, 0, size);
      }

      String filename = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS").format(LocalDateTime.now());
      Path uploadfile = Paths.get("C:\\\\work\\" + filename);

      try (OutputStream os = Files.newOutputStream(uploadfile, StandardOpenOption.CREATE)) {
          os.write(byteos.toByteArray());
      } catch (IOException ex) {
          System.err.println(ex);
      }
  }  
}
