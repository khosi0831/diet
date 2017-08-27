package com.diet.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Table(name = "Weight")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Weight {
	 @Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	private Integer week;
	private Integer userId;
	private String w0 = "";
	private String w1 = "";
	private String w2 = "";
	private String w3 = "";
	private String w4 = "";
	private String w5 = "";
	private String w6 = "";
	private String w7 = "";
	private String w8 = "";
	private String w9 = "";
	private String w10 = "";
	private String w11 = "";
	private String w12 = "";
	private String wmax1 = "";
	private String wmax2 = "";
	private String wmax3 = "";
	private String wmax4 = "";
	private String wmax5 = "";
	private String wmax6 = "";
	private String wmax7 = "";
	private String wmax8 = "";
	private String wmax9 = "";
	private String wmax10 = "";
	private String wmax11 = "";
	private String wmax12 = "";
	private String wmin1 = "";
	private String wmin2 = "";
	private String wmin3 = "";
	private String wmin4 = "";
	private String wmin5 = "";
	private String wmin6 = "";
	private String wmin7 = "";
	private String wmin8 = "";
	private String wmin9 = "";
	private String wmin10 = "";
	private String wmin11 = "";
	private String wmin12 = "";
	private String wscale1 = "";
	private String wscale2 = "";
	private String wscale3 = "";
	private String wscale4 = "";
	private String wscale5 = "";
	private String wscale6 = "";
	private String wscale7 = "";
	private String wscale8 = "";
	private String wscale9 = "";
	private String wscale10 = "";
	private String wscale11 = "";
	private String wscale12 = "";
	private String m0 = "";
	private String m1 = "";
	private String m2 = "";
	private String m3 = "";
	private String m4 = "";
	private String m5 = "";
	private String m6 = "";
	private String m7 = "";
	private String m8 = "";
	private String m9 = "";
	private String m10 = "";
	private String m11 = "";
	private String m12 = "";
	private String mmax1 = "";
	private String mmax2 = "";
	private String mmax3 = "";
	private String mmax4 = "";
	private String mmax5 = "";
	private String mmax6 = "";
	private String mmax7 = "";
	private String mmax8 = "";
	private String mmax9 = "";
	private String mmax10 = "";
	private String mmax11 = "";
	private String mmax12 = "";
	private String mmin1 = "";
	private String mmin2 = "";
	private String mmin3 = "";
	private String mmin4 = "";
	private String mmin5 = "";
	private String mmin6 = "";
	private String mmin7 = "";
	private String mmin8 = "";
	private String mmin9 = "";
	private String mmin10 = "";
	private String mmin11 = "";
	private String mmin12 = "";
	private String mscale1 = "";
	private String mscale2 = "";
	private String mscale3 = "";
	private String mscale4 = "";
	private String mscale5 = "";
	private String mscale6 = "";
	private String mscale7 = "";
	private String mscale8 = "";
	private String mscale9 = "";
	private String mscale10 = "";
	private String mscale11 = "";
	private String mscale12 = "";
	 
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getWeek() {
		return week;
	}
	public void setWeek(Integer week) {
		this.week = week;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getW0() {
		return w0;
	}
	public void setW0(String w0) {
		this.w0 = w0;
	}
	public String getW1() {
		return w1;
	}
	public void setW1(String w1) {
		this.w1 = w1;
	}
	public String getW2() {
		return w2;
	}
	public void setW2(String w2) {
		this.w2 = w2;
	}
	public String getW3() {
		return w3;
	}
	public void setW3(String w3) {
		this.w3 = w3;
	}
	public String getW4() {
		return w4;
	}
	public void setW4(String w4) {
		this.w4 = w4;
	}
	public String getW5() {
		return w5;
	}
	public void setW5(String w5) {
		this.w5 = w5;
	}
	public String getW6() {
		return w6;
	}
	public void setW6(String w6) {
		this.w6 = w6;
	}
	public String getW7() {
		return w7;
	}
	public void setW7(String w7) {
		this.w7 = w7;
	}
	public String getW8() {
		return w8;
	}
	public void setW8(String w8) {
		this.w8 = w8;
	}
	public String getW9() {
		return w9;
	}
	public void setW9(String w9) {
		this.w9 = w9;
	}
	public String getW10() {
		return w10;
	}
	public void setW10(String w10) {
		this.w10 = w10;
	}
	public String getW11() {
		return w11;
	}
	public void setW11(String w11) {
		this.w11 = w11;
	}
	public String getW12() {
		return w12;
	}
	public void setW12(String w12) {
		this.w12 = w12;
	}
	public String getWmax1() {
		return wmax1;
	}
	public void setWmax1(String wmax1) {
		this.wmax1 = wmax1;
	}
	public String getWmax2() {
		return wmax2;
	}
	public void setWmax2(String wmax2) {
		this.wmax2 = wmax2;
	}
	public String getWmax3() {
		return wmax3;
	}
	public void setWmax3(String wmax3) {
		this.wmax3 = wmax3;
	}
	public String getWmax4() {
		return wmax4;
	}
	public void setWmax4(String wmax4) {
		this.wmax4 = wmax4;
	}
	public String getWmax5() {
		return wmax5;
	}
	public void setWmax5(String wmax5) {
		this.wmax5 = wmax5;
	}
	public String getWmax6() {
		return wmax6;
	}
	public void setWmax6(String wmax6) {
		this.wmax6 = wmax6;
	}
	public String getWmax7() {
		return wmax7;
	}
	public void setWmax7(String wmax7) {
		this.wmax7 = wmax7;
	}
	public String getWmax8() {
		return wmax8;
	}
	public void setWmax8(String wmax8) {
		this.wmax8 = wmax8;
	}
	public String getWmax9() {
		return wmax9;
	}
	public void setWmax9(String wmax9) {
		this.wmax9 = wmax9;
	}
	public String getWmax10() {
		return wmax10;
	}
	public void setWmax10(String wmax10) {
		this.wmax10 = wmax10;
	}
	public String getWmax11() {
		return wmax11;
	}
	public void setWmax11(String wmax11) {
		this.wmax11 = wmax11;
	}
	public String getWmax12() {
		return wmax12;
	}
	public void setWmax12(String wmax12) {
		this.wmax12 = wmax12;
	}
	public String getWmin1() {
		return wmin1;
	}
	public void setWmin1(String wmin1) {
		this.wmin1 = wmin1;
	}
	public String getWmin2() {
		return wmin2;
	}
	public void setWmin2(String wmin2) {
		this.wmin2 = wmin2;
	}
	public String getWmin3() {
		return wmin3;
	}
	public void setWmin3(String wmin3) {
		this.wmin3 = wmin3;
	}
	public String getWmin4() {
		return wmin4;
	}
	public void setWmin4(String wmin4) {
		this.wmin4 = wmin4;
	}
	public String getWmin5() {
		return wmin5;
	}
	public void setWmin5(String wmin5) {
		this.wmin5 = wmin5;
	}
	public String getWmin6() {
		return wmin6;
	}
	public void setWmin6(String wmin6) {
		this.wmin6 = wmin6;
	}
	public String getWmin7() {
		return wmin7;
	}
	public void setWmin7(String wmin7) {
		this.wmin7 = wmin7;
	}
	public String getWmin8() {
		return wmin8;
	}
	public void setWmin8(String wmin8) {
		this.wmin8 = wmin8;
	}
	public String getWmin9() {
		return wmin9;
	}
	public void setWmin9(String wmin9) {
		this.wmin9 = wmin9;
	}
	public String getWmin10() {
		return wmin10;
	}
	public void setWmin10(String wmin10) {
		this.wmin10 = wmin10;
	}
	public String getWmin11() {
		return wmin11;
	}
	public void setWmin11(String wmin11) {
		this.wmin11 = wmin11;
	}
	public String getWmin12() {
		return wmin12;
	}
	public void setWmin12(String wmin12) {
		this.wmin12 = wmin12;
	}
	public String getWscale1() {
		return wscale1;
	}
	public void setWscale1(String wscale1) {
		this.wscale1 = wscale1;
	}
	public String getWscale2() {
		return wscale2;
	}
	public void setWscale2(String wscale2) {
		this.wscale2 = wscale2;
	}
	public String getWscale3() {
		return wscale3;
	}
	public void setWscale3(String wscale3) {
		this.wscale3 = wscale3;
	}
	public String getWscale4() {
		return wscale4;
	}
	public void setWscale4(String wscale4) {
		this.wscale4 = wscale4;
	}
	public String getWscale5() {
		return wscale5;
	}
	public void setWscale5(String wscale5) {
		this.wscale5 = wscale5;
	}
	public String getWscale6() {
		return wscale6;
	}
	public void setWscale6(String wscale6) {
		this.wscale6 = wscale6;
	}
	public String getWscale7() {
		return wscale7;
	}
	public void setWscale7(String wscale7) {
		this.wscale7 = wscale7;
	}
	public String getWscale8() {
		return wscale8;
	}
	public void setWscale8(String wscale8) {
		this.wscale8 = wscale8;
	}
	public String getWscale9() {
		return wscale9;
	}
	public void setWscale9(String wscale9) {
		this.wscale9 = wscale9;
	}
	public String getWscale10() {
		return wscale10;
	}
	public void setWscale10(String wscale10) {
		this.wscale10 = wscale10;
	}
	public String getWscale11() {
		return wscale11;
	}
	public void setWscale11(String wscale11) {
		this.wscale11 = wscale11;
	}
	public String getWscale12() {
		return wscale12;
	}
	public void setWscale12(String wscale12) {
		this.wscale12 = wscale12;
	}
	public String getM0() {
		return m0;
	}
	public void setM0(String m0) {
		this.m0 = m0;
	}
	public String getM1() {
		return m1;
	}
	public void setM1(String m1) {
		this.m1 = m1;
	}
	public String getM2() {
		return m2;
	}
	public void setM2(String m2) {
		this.m2 = m2;
	}
	public String getM3() {
		return m3;
	}
	public void setM3(String m3) {
		this.m3 = m3;
	}
	public String getM4() {
		return m4;
	}
	public void setM4(String m4) {
		this.m4 = m4;
	}
	public String getM5() {
		return m5;
	}
	public void setM5(String m5) {
		this.m5 = m5;
	}
	public String getM6() {
		return m6;
	}
	public void setM6(String m6) {
		this.m6 = m6;
	}
	public String getM7() {
		return m7;
	}
	public void setM7(String m7) {
		this.m7 = m7;
	}
	public String getM8() {
		return m8;
	}
	public void setM8(String m8) {
		this.m8 = m8;
	}
	public String getM9() {
		return m9;
	}
	public void setM9(String m9) {
		this.m9 = m9;
	}
	public String getM10() {
		return m10;
	}
	public void setM10(String m10) {
		this.m10 = m10;
	}
	public String getM11() {
		return m11;
	}
	public void setM11(String m11) {
		this.m11 = m11;
	}
	public String getM12() {
		return m12;
	}
	public void setM12(String m12) {
		this.m12 = m12;
	}
	public String getMmax1() {
		return mmax1;
	}
	public void setMmax1(String mmax1) {
		this.mmax1 = mmax1;
	}
	public String getMmax2() {
		return mmax2;
	}
	public void setMmax2(String mmax2) {
		this.mmax2 = mmax2;
	}
	public String getMmax3() {
		return mmax3;
	}
	public void setMmax3(String mmax3) {
		this.mmax3 = mmax3;
	}
	public String getMmax4() {
		return mmax4;
	}
	public void setMmax4(String mmax4) {
		this.mmax4 = mmax4;
	}
	public String getMmax5() {
		return mmax5;
	}
	public void setMmax5(String mmax5) {
		this.mmax5 = mmax5;
	}
	public String getMmax6() {
		return mmax6;
	}
	public void setMmax6(String mmax6) {
		this.mmax6 = mmax6;
	}
	public String getMmax7() {
		return mmax7;
	}
	public void setMmax7(String mmax7) {
		this.mmax7 = mmax7;
	}
	public String getMmax8() {
		return mmax8;
	}
	public void setMmax8(String mmax8) {
		this.mmax8 = mmax8;
	}
	public String getMmax9() {
		return mmax9;
	}
	public void setMmax9(String mmax9) {
		this.mmax9 = mmax9;
	}
	public String getMmax10() {
		return mmax10;
	}
	public void setMmax10(String mmax10) {
		this.mmax10 = mmax10;
	}
	public String getMmax11() {
		return mmax11;
	}
	public void setMmax11(String mmax11) {
		this.mmax11 = mmax11;
	}
	public String getMmax12() {
		return mmax12;
	}
	public void setMmax12(String mmax12) {
		this.mmax12 = mmax12;
	}
	public String getMmin1() {
		return mmin1;
	}
	public void setMmin1(String mmin1) {
		this.mmin1 = mmin1;
	}
	public String getMmin2() {
		return mmin2;
	}
	public void setMmin2(String mmin2) {
		this.mmin2 = mmin2;
	}
	public String getMmin3() {
		return mmin3;
	}
	public void setMmin3(String mmin3) {
		this.mmin3 = mmin3;
	}
	public String getMmin4() {
		return mmin4;
	}
	public void setMmin4(String mmin4) {
		this.mmin4 = mmin4;
	}
	public String getMmin5() {
		return mmin5;
	}
	public void setMmin5(String mmin5) {
		this.mmin5 = mmin5;
	}
	public String getMmin6() {
		return mmin6;
	}
	public void setMmin6(String mmin6) {
		this.mmin6 = mmin6;
	}
	public String getMmin7() {
		return mmin7;
	}
	public void setMmin7(String mmin7) {
		this.mmin7 = mmin7;
	}
	public String getMmin8() {
		return mmin8;
	}
	public void setMmin8(String mmin8) {
		this.mmin8 = mmin8;
	}
	public String getMmin9() {
		return mmin9;
	}
	public void setMmin9(String mmin9) {
		this.mmin9 = mmin9;
	}
	public String getMmin10() {
		return mmin10;
	}
	public void setMmin10(String mmin10) {
		this.mmin10 = mmin10;
	}
	public String getMmin11() {
		return mmin11;
	}
	public void setMmin11(String mmin11) {
		this.mmin11 = mmin11;
	}
	public String getMmin12() {
		return mmin12;
	}
	public void setMmin12(String mmin12) {
		this.mmin12 = mmin12;
	}
	public String getMscale1() {
		return mscale1;
	}
	public void setMscale1(String mscale1) {
		this.mscale1 = mscale1;
	}
	public String getMscale2() {
		return mscale2;
	}
	public void setMscale2(String mscale2) {
		this.mscale2 = mscale2;
	}
	public String getMscale3() {
		return mscale3;
	}
	public void setMscale3(String mscale3) {
		this.mscale3 = mscale3;
	}
	public String getMscale4() {
		return mscale4;
	}
	public void setMscale4(String mscale4) {
		this.mscale4 = mscale4;
	}
	public String getMscale5() {
		return mscale5;
	}
	public void setMscale5(String mscale5) {
		this.mscale5 = mscale5;
	}
	public String getMscale6() {
		return mscale6;
	}
	public void setMscale6(String mscale6) {
		this.mscale6 = mscale6;
	}
	public String getMscale7() {
		return mscale7;
	}
	public void setMscale7(String mscale7) {
		this.mscale7 = mscale7;
	}
	public String getMscale8() {
		return mscale8;
	}
	public void setMscale8(String mscale8) {
		this.mscale8 = mscale8;
	}
	public String getMscale9() {
		return mscale9;
	}
	public void setMscale9(String mscale9) {
		this.mscale9 = mscale9;
	}
	public String getMscale10() {
		return mscale10;
	}
	public void setMscale10(String mscale10) {
		this.mscale10 = mscale10;
	}
	public String getMscale11() {
		return mscale11;
	}
	public void setMscale11(String mscale11) {
		this.mscale11 = mscale11;
	}
	public String getMscale12() {
		return mscale12;
	}
	public void setMscale12(String mscale12) {
		this.mscale12 = mscale12;
	}
	 
}
