$PBExportHeader$wi_con_revisa_fam_form.srw
forward
global type wi_con_revisa_fam_form from w_int_con_empresa
end type
type st_familia from statictext within wi_con_revisa_fam_form
end type
type uo_familia from u_em_campo_2 within wi_con_revisa_fam_form
end type
type uo_formato from u_em_campo_2 within wi_con_revisa_fam_form
end type
type st_formato from statictext within wi_con_revisa_fam_form
end type
type r_1 from rectangle within wi_con_revisa_fam_form
end type
type r_2 from rectangle within wi_con_revisa_fam_form
end type
type r_3 from rectangle within wi_con_revisa_fam_form
end type
type r_4 from rectangle within wi_con_revisa_fam_form
end type
type r_5 from rectangle within wi_con_revisa_fam_form
end type
type r_6 from rectangle within wi_con_revisa_fam_form
end type
type r_7 from rectangle within wi_con_revisa_fam_form
end type
type r_8 from rectangle within wi_con_revisa_fam_form
end type
type r_9 from rectangle within wi_con_revisa_fam_form
end type
type r_10 from rectangle within wi_con_revisa_fam_form
end type
type r_11 from rectangle within wi_con_revisa_fam_form
end type
type r_12 from rectangle within wi_con_revisa_fam_form
end type
type r_13 from rectangle within wi_con_revisa_fam_form
end type
type r_14 from rectangle within wi_con_revisa_fam_form
end type
type r_15 from rectangle within wi_con_revisa_fam_form
end type
type r_16 from rectangle within wi_con_revisa_fam_form
end type
type r_17 from rectangle within wi_con_revisa_fam_form
end type
type r_18 from rectangle within wi_con_revisa_fam_form
end type
type cb_1 from commandbutton within wi_con_revisa_fam_form
end type
type uo_articulo from u_em_campo_2 within wi_con_revisa_fam_form
end type
type st_articulo from statictext within wi_con_revisa_fam_form
end type
type st_1 from statictext within wi_con_revisa_fam_form
end type
type st_2 from statictext within wi_con_revisa_fam_form
end type
type sle_1 from singlelineedit within wi_con_revisa_fam_form
end type
type sle_2 from singlelineedit within wi_con_revisa_fam_form
end type
type st_3 from statictext within wi_con_revisa_fam_form
end type
type st_4 from statictext within wi_con_revisa_fam_form
end type
type sle_3 from singlelineedit within wi_con_revisa_fam_form
end type
type sle_4 from singlelineedit within wi_con_revisa_fam_form
end type
type pb_1 from upb_salir within wi_con_revisa_fam_form
end type
end forward

global type wi_con_revisa_fam_form from w_int_con_empresa
integer width = 2894
integer height = 1200
st_familia st_familia
uo_familia uo_familia
uo_formato uo_formato
st_formato st_formato
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
r_6 r_6
r_7 r_7
r_8 r_8
r_9 r_9
r_10 r_10
r_11 r_11
r_12 r_12
r_13 r_13
r_14 r_14
r_15 r_15
r_16 r_16
r_17 r_17
r_18 r_18
cb_1 cb_1
uo_articulo uo_articulo
st_articulo st_articulo
st_1 st_1
st_2 st_2
sle_1 sle_1
sle_2 sle_2
st_3 st_3
st_4 st_4
sle_3 sle_3
sle_4 sle_4
pb_1 pb_1
end type
global wi_con_revisa_fam_form wi_con_revisa_fam_form

type variables
String tipo = "1"
end variables

on wi_con_revisa_fam_form.create
int iCurrent
call super::create
this.st_familia=create st_familia
this.uo_familia=create uo_familia
this.uo_formato=create uo_formato
this.st_formato=create st_formato
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.r_6=create r_6
this.r_7=create r_7
this.r_8=create r_8
this.r_9=create r_9
this.r_10=create r_10
this.r_11=create r_11
this.r_12=create r_12
this.r_13=create r_13
this.r_14=create r_14
this.r_15=create r_15
this.r_16=create r_16
this.r_17=create r_17
this.r_18=create r_18
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.st_articulo=create st_articulo
this.st_1=create st_1
this.st_2=create st_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_3=create st_3
this.st_4=create st_4
this.sle_3=create sle_3
this.sle_4=create sle_4
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_familia
this.Control[iCurrent+2]=this.uo_familia
this.Control[iCurrent+3]=this.uo_formato
this.Control[iCurrent+4]=this.st_formato
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.r_2
this.Control[iCurrent+7]=this.r_3
this.Control[iCurrent+8]=this.r_4
this.Control[iCurrent+9]=this.r_5
this.Control[iCurrent+10]=this.r_6
this.Control[iCurrent+11]=this.r_7
this.Control[iCurrent+12]=this.r_8
this.Control[iCurrent+13]=this.r_9
this.Control[iCurrent+14]=this.r_10
this.Control[iCurrent+15]=this.r_11
this.Control[iCurrent+16]=this.r_12
this.Control[iCurrent+17]=this.r_13
this.Control[iCurrent+18]=this.r_14
this.Control[iCurrent+19]=this.r_15
this.Control[iCurrent+20]=this.r_16
this.Control[iCurrent+21]=this.r_17
this.Control[iCurrent+22]=this.r_18
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.uo_articulo
this.Control[iCurrent+25]=this.st_articulo
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.st_2
this.Control[iCurrent+28]=this.sle_1
this.Control[iCurrent+29]=this.sle_2
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.st_4
this.Control[iCurrent+32]=this.sle_3
this.Control[iCurrent+33]=this.sle_4
this.Control[iCurrent+34]=this.pb_1
end on

on wi_con_revisa_fam_form.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_familia)
destroy(this.uo_familia)
destroy(this.uo_formato)
destroy(this.st_formato)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.r_6)
destroy(this.r_7)
destroy(this.r_8)
destroy(this.r_9)
destroy(this.r_10)
destroy(this.r_11)
destroy(this.r_12)
destroy(this.r_13)
destroy(this.r_14)
destroy(this.r_15)
destroy(this.r_16)
destroy(this.r_17)
destroy(this.r_18)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.st_articulo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Actualización de familias y formatos de articulos modificados"
istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

f_activar_campo(uo_articulo.em_campo)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_revisa_fam_form
integer x = 718
integer y = 1396
integer height = 56
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_revisa_fam_form
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_con_revisa_fam_form
end type

type st_familia from statictext within wi_con_revisa_fam_form
integer x = 18
integer y = 312
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Familia"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_familia from u_em_campo_2 within wi_con_revisa_fam_form
integer x = 233
integer y = 308
integer width = 955
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_familias"
ue_filtro = ""
end event

event modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)
If Trim(uo_familia.em_campo.text)="" then
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
	Return
end if 

end event

type uo_formato from u_em_campo_2 within wi_con_revisa_fam_form
event destroy ( )
integer x = 1490
integer y = 308
integer width = 827
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato(codigo_empresa,uo_formato.em_codigo.text)
If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

type st_formato from statictext within wi_con_revisa_fam_form
integer x = 1253
integer y = 316
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Formato"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type r_1 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 306
integer y = 416
integer width = 114
integer height = 448
end type

type r_2 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 430
integer y = 416
integer width = 114
integer height = 448
end type

type r_3 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 553
integer y = 416
integer width = 114
integer height = 448
end type

type r_4 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 677
integer y = 416
integer width = 114
integer height = 448
end type

type r_5 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 800
integer y = 416
integer width = 114
integer height = 448
end type

type r_6 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 923
integer y = 416
integer width = 114
integer height = 448
end type

type r_7 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1047
integer y = 416
integer width = 114
integer height = 448
end type

type r_8 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1170
integer y = 416
integer width = 114
integer height = 448
end type

type r_9 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1294
integer y = 416
integer width = 114
integer height = 448
end type

type r_10 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1417
integer y = 416
integer width = 114
integer height = 448
end type

type r_11 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1541
integer y = 416
integer width = 114
integer height = 448
end type

type r_12 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1664
integer y = 416
integer width = 114
integer height = 448
end type

type r_13 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1787
integer y = 416
integer width = 114
integer height = 448
end type

type r_14 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 1911
integer y = 416
integer width = 114
integer height = 448
end type

type r_15 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 2034
integer y = 416
integer width = 114
integer height = 448
end type

type r_16 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 2158
integer y = 416
integer width = 114
integer height = 448
end type

type r_17 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 2281
integer y = 416
integer width = 114
integer height = 448
end type

type r_18 from rectangle within wi_con_revisa_fam_form
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 15780518
integer x = 2405
integer y = 416
integer width = 114
integer height = 448
end type

type cb_1 from commandbutton within wi_con_revisa_fam_form
integer x = 14
integer y = 436
integer width = 274
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;long indice,total,var_incidencias,modificaciones,errores
string sel,var_articulo,var_familia,var_formato,var_tabla
boolean continuar
string v_articulo,v_familia,v_formato
datastore articulos

v_articulo = ""
v_familia  = ""
v_formato  = ""

if trim(uo_articulo.em_codigo.text) <> "" then
	v_articulo = " and codigo = '"+uo_articulo.em_codigo.text+"'"
	uo_familia.em_codigo.text = ""
	uo_familia.em_campo.text = ""
	uo_formato.em_codigo.text = ""
	uo_formato.em_campo.text = ""
else
	if trim(uo_familia.em_codigo.text) <> "" then
		v_familia = " and familia = '"+uo_familia.em_codigo.text+"'"
	end if
	if trim(uo_formato.em_codigo.text) <> "" then
		v_formato = " and formato = '"+uo_formato.em_codigo.text+"'"
	end if
	
end if

sel       = "select codigo,familia,formato "+&
		      "from articulos where empresa = '"+codigo_empresa+"'"+&
				v_articulo+v_familia+v_formato

//articulos = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, articulos)


total     = articulos.rowcount()
continuar = true
modificaciones = 0
errores        = 0
sle_1.text = string(total,"#####0")
for indice = 1 to total
	r_1.fillcolor = rgb(255,255,255)
	r_2.fillcolor = rgb(255,255,255)
	r_3.fillcolor = rgb(255,255,255)
	r_4.fillcolor = rgb(255,255,255)
	r_5.fillcolor = rgb(255,255,255)
	r_6.fillcolor = rgb(255,255,255)
	r_7.fillcolor = rgb(255,255,255)
	r_8.fillcolor = rgb(255,255,255)
	r_9.fillcolor = rgb(255,255,255)
	r_10.fillcolor = rgb(255,255,255)
	r_11.fillcolor = rgb(255,255,255)
	r_12.fillcolor = rgb(255,255,255)
	r_13.fillcolor = rgb(255,255,255)
	r_14.fillcolor = rgb(255,255,255)
	r_15.fillcolor = rgb(255,255,255)
	r_16.fillcolor = rgb(255,255,255)
	r_17.fillcolor = rgb(255,255,255)
	r_18.fillcolor = rgb(255,255,255)

	f_mensaje_proceso("Procesando articulos:",indice,total)
	var_articulo = articulos.object.codigo[indice]
	var_familia  = articulos.object.familia[indice]
	var_formato  = articulos.object.formato[indice]
	// alminvent
	if continuar then
		select count(*) into :var_incidencias
		from  alminvent
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_1.fillcolor = rgb(255,0,0)
			update alminvent
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_1.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_1.fillcolor = rgb(0,255,0)
		end if
	end if
	// almlinubica
	if continuar then
		select count(*) into :var_incidencias
		from  almlinubica
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_2.fillcolor = rgb(255,0,0)
			update almlinubica
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_2.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_2.fillcolor = rgb(0,255,0)
		end if
			
	end if
	// almlinubicahis
	if continuar then
		select count(*) into :var_incidencias
		from  almlinubicahis
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_3.fillcolor = rgb(255,0,0)
			update almlinubicahis
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_3.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_3.fillcolor = rgb(0,255,0)
		end if
	end if
	// almmovhis
	if continuar then
		select count(*) into :var_incidencias
		from  almmovhis
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_4.fillcolor = rgb(255,0,0)
			update almmovhis
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_4.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_4.fillcolor = rgb(0,255,0)
		end if
	end if
	// almtoma
	if continuar then
		select count(*) into :var_incidencias
		from  almtoma
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_5.fillcolor = rgb(255,0,0)
			update almtoma
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_5.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_5.fillcolor = rgb(0,255,0)
		end if
	end if
	// decoraalb
	if continuar then
		select count(*) into :var_incidencias
		from  decoraalb
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_6.fillcolor = rgb(255,0,0)
			update decoraalb
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_6.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_6.fillcolor = rgb(0,255,0)
		end if

	end if
	// decoralinalb
	if continuar then
		select count(*) into :var_incidencias
		from  decoralinalb
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_7.fillcolor = rgb(255,0,0)
			update decoralinalb
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_7.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_7.fillcolor = rgb(0,255,0)
		end if
	end if
	// deplinubica
	if continuar then
		select count(*) into :var_incidencias
		from  deplinubica
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_8.fillcolor = rgb(255,0,0)
			update deplinubica
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_8.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_8.fillcolor = rgb(0,255,0)
		end if
	end if
	// depmovhis
	if continuar then
		select count(*) into :var_incidencias
		from  depmovhis
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_9.fillcolor = rgb(255,0,0)
			update depmovhis
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_9.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_9.fillcolor = rgb(0,255,0)
		end if
	end if
	// prodlinparte
//	if continuar then
//		select count(*) into :var_incidencias
//		from  prodlinparte
//		where empresa  = :codigo_empresa
//		and   articulo = :var_articulo
//		and   (familia <> :var_familia or formato <> :var_formato);
//		if isnull(var_incidencias) then var_incidencias = 0
//		if var_incidencias > 0 then
//			modificaciones ++
//			r_10.fillcolor = rgb(255,0,0)
//			update prodlinparte
//			set    familia = : var_familia,formato = :var_formato
//			where empresa  = :codigo_empresa
//			and   articulo = :var_articulo
//			and   (familia <> :var_familia or formato <> :var_formato);
//			if sqlca.sqlcode <> 0 then 
//				continuar = false
//				errores ++
//				r_10.fillcolor = rgb(0,0,0)
//			end if
//			
//		else
			r_10.fillcolor = rgb(0,255,0)
//		end if
//	end if
	// venartcli
	if continuar then
		select count(*) into :var_incidencias
		from  venartcli
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_11.fillcolor = rgb(255,0,0)
			update venartcli
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_11.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_11.fillcolor = rgb(0,255,0)
		end if
	end if
	// vendtoartcli
	if continuar then
		select count(*) into :var_incidencias
		from  vendtoartcli
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_12.fillcolor = rgb(255,0,0)
			update vendtoartcli
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_12.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_12.fillcolor = rgb(0,255,0)
		end if
	end if
	// venlialb
	if continuar then
		select count(*) into :var_incidencias
		from  venlialb
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_13.fillcolor = rgb(255,0,0)
			update venlialb
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_13.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_13.fillcolor = rgb(0,255,0)
		end if
	end if
	// venlialb2
	if continuar then
		select count(*) into :var_incidencias
		from  venlialb2
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_14.fillcolor = rgb(255,0,0)
			update venlialb2
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_14.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_14.fillcolor = rgb(0,255,0)
		end if
	end if
	// venlifac
	if continuar then
		select count(*) into :var_incidencias
		from  venlifac
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_15.fillcolor = rgb(255,0,0)
			update venlifac
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_15.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_15.fillcolor = rgb(0,255,0)
		end if
	end if
	// venlintarifas
	if continuar then
		select count(*) into :var_incidencias
		from  venlintarifas
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_16.fillcolor = rgb(255,0,0)
			update venlintarifas
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_16.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_16.fillcolor = rgb(0,255,0)
		end if
	end if
	// venliped
	if continuar then
		select count(*) into :var_incidencias
		from  venliped
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_17.fillcolor = rgb(255,0,0)
			update venliped
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_17.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_17.fillcolor = rgb(0,255,0)
		end if
	end if
	// planificacion
	if continuar then
		select count(*) into :var_incidencias
		from  planificacion
		where empresa  = :codigo_empresa
		and   cod_articulo = :var_articulo;
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_17.fillcolor = rgb(255,0,0)
			update planificacion
			set    formato = :var_formato
			where empresa  = :codigo_empresa
			and   cod_articulo = :var_articulo;
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_17.fillcolor = rgb(0,0,0)
			end if
		else
			r_17.fillcolor = rgb(0,255,0)
		end if
	end if

	// venliproformas
	if continuar then
		select count(*) into :var_incidencias
		from  venliproformas
		where empresa  = :codigo_empresa
		and   articulo = :var_articulo
		and   (familia <> :var_familia or formato <> :var_formato);
		if isnull(var_incidencias) then var_incidencias = 0
		if var_incidencias > 0 then
			modificaciones ++
			r_18.fillcolor = rgb(255,0,0)
			update venliproformas
			set    familia = : var_familia,formato = :var_formato
			where empresa  = :codigo_empresa
			and   articulo = :var_articulo
			and   (familia <> :var_familia or formato <> :var_formato);
			if sqlca.sqlcode <> 0 then 
				continuar = false
				errores ++
				r_18.fillcolor = rgb(0,0,0)
			end if
			
		else
			r_18.fillcolor = rgb(0,255,0)
		end if
	end if	
	////////Fin
	if continuar then
		commit;
	else
		rollback;
	end if
	continuar = true
	sle_2.text = string(indice,"#####0")
	sle_3.text = string(modificaciones,"#####0")
	sle_4.text = string(errores,"#####0")
next
destroy articulos



end event

type uo_articulo from u_em_campo_2 within wi_con_revisa_fam_form
event destroy ( )
integer x = 238
integer y = 188
integer width = 759
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF

end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

type st_articulo from statictext within wi_con_revisa_fam_form
integer x = 18
integer y = 196
integer width = 206
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_1 from statictext within wi_con_revisa_fam_form
integer x = 37
integer y = 924
integer width = 279
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Articulos :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within wi_con_revisa_fam_form
integer x = 690
integer y = 924
integer width = 338
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Procesados :"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within wi_con_revisa_fam_form
integer x = 343
integer y = 916
integer width = 334
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within wi_con_revisa_fam_form
integer x = 1038
integer y = 916
integer width = 334
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within wi_con_revisa_fam_form
integer x = 1381
integer y = 924
integer width = 430
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Actualizaciones :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_con_revisa_fam_form
integer x = 2171
integer y = 924
integer width = 274
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Errores :"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within wi_con_revisa_fam_form
integer x = 1819
integer y = 916
integer width = 334
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_4 from singlelineedit within wi_con_revisa_fam_form
integer x = 2464
integer y = 916
integer width = 334
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from upb_salir within wi_con_revisa_fam_form
integer x = 2711
integer y = 28
integer width = 123
integer height = 108
integer taborder = 0
boolean bringtotop = true
end type

