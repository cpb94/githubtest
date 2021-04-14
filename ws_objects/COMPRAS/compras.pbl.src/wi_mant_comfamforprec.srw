$PBExportHeader$wi_mant_comfamforprec.srw
forward
global type wi_mant_comfamforprec from w_int_con_empresa
end type
type st_1 from statictext within wi_mant_comfamforprec
end type
type uo_proveedor from u_em_campo_2 within wi_mant_comfamforprec
end type
type dw_1 from u_datawindow_consultas within wi_mant_comfamforprec
end type
type cb_consulta from u_boton within wi_mant_comfamforprec
end type
type cb_generar from u_boton within wi_mant_comfamforprec
end type
type pb_1 from upb_salir within wi_mant_comfamforprec
end type
type cb_procesar from u_boton within wi_mant_comfamforprec
end type
type cb_cancelar from u_boton within wi_mant_comfamforprec
end type
type gb_1 from groupbox within wi_mant_comfamforprec
end type
type st_2 from statictext within wi_mant_comfamforprec
end type
type st_3 from statictext within wi_mant_comfamforprec
end type
type st_4 from statictext within wi_mant_comfamforprec
end type
type uo_familia from u_em_campo_2 within wi_mant_comfamforprec
end type
type uo_formato from u_em_campo_2 within wi_mant_comfamforprec
end type
type em_precio from u_em_campo within wi_mant_comfamforprec
end type
type pb_2 from picturebutton within wi_mant_comfamforprec
end type
type pb_3 from picturebutton within wi_mant_comfamforprec
end type
type cb_insertar from u_boton within wi_mant_comfamforprec
end type
type cb_grabar from u_boton within wi_mant_comfamforprec
end type
type st_5 from statictext within wi_mant_comfamforprec
end type
type uo_calidad from u_em_campo_2 within wi_mant_comfamforprec
end type
end forward

global type wi_mant_comfamforprec from w_int_con_empresa
integer width = 3017
integer height = 1452
st_1 st_1
uo_proveedor uo_proveedor
dw_1 dw_1
cb_consulta cb_consulta
cb_generar cb_generar
pb_1 pb_1
cb_procesar cb_procesar
cb_cancelar cb_cancelar
gb_1 gb_1
st_2 st_2
st_3 st_3
st_4 st_4
uo_familia uo_familia
uo_formato uo_formato
em_precio em_precio
pb_2 pb_2
pb_3 pb_3
cb_insertar cb_insertar
cb_grabar cb_grabar
st_5 st_5
uo_calidad uo_calidad
end type
global wi_mant_comfamforprec wi_mant_comfamforprec

on wi_mant_comfamforprec.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_proveedor=create uo_proveedor
this.dw_1=create dw_1
this.cb_consulta=create cb_consulta
this.cb_generar=create cb_generar
this.pb_1=create pb_1
this.cb_procesar=create cb_procesar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.uo_familia=create uo_familia
this.uo_formato=create uo_formato
this.em_precio=create em_precio
this.pb_2=create pb_2
this.pb_3=create pb_3
this.cb_insertar=create cb_insertar
this.cb_grabar=create cb_grabar
this.st_5=create st_5
this.uo_calidad=create uo_calidad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_proveedor
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.cb_generar
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.cb_procesar
this.Control[iCurrent+8]=this.cb_cancelar
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.uo_familia
this.Control[iCurrent+14]=this.uo_formato
this.Control[iCurrent+15]=this.em_precio
this.Control[iCurrent+16]=this.pb_2
this.Control[iCurrent+17]=this.pb_3
this.Control[iCurrent+18]=this.cb_insertar
this.Control[iCurrent+19]=this.cb_grabar
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.uo_calidad
end on

on wi_mant_comfamforprec.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_proveedor)
destroy(this.dw_1)
destroy(this.cb_consulta)
destroy(this.cb_generar)
destroy(this.pb_1)
destroy(this.cb_procesar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_familia)
destroy(this.uo_formato)
destroy(this.em_precio)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.cb_insertar)
destroy(this.cb_grabar)
destroy(this.st_5)
destroy(this.uo_calidad)
end on

event open;call super::open;this.title = "Introducción de precios de compra por familia y formato"
dw_1.SetTransObject(sqlca)

f_activar_campo(uo_proveedor.em_campo)
end event

event ue_f3;cb_procesar.TriggerEvent("clicked")
end event

event ue_esc;cb_cancelar.TriggerEvent("clicked")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_comfamforprec
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_comfamforprec
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_comfamforprec
end type

type st_1 from statictext within wi_mant_comfamforprec
integer x = 82
integer y = 184
integer width = 283
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Proveedor"
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within wi_mant_comfamforprec
integer x = 402
integer y = 180
integer width = 1294
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

event modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 

end event

type dw_1 from u_datawindow_consultas within wi_mant_comfamforprec
integer x = 50
integer y = 288
integer width = 1966
integer height = 652
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_comfamforprec"
borderstyle borderstyle = styleraised!
end type

type cb_consulta from u_boton within wi_mant_comfamforprec
integer x = 2066
integer y = 304
integer width = 379
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;if uo_proveedor.em_codigo.text = "" then
	f_mensaje("Consulta de los precios por familia y formato", "Ha de introducir un proveedor")
	return
end if

dw_1.retrieve (codigo_empresa,uo_proveedor.em_codigo.text)
end event

type cb_generar from u_boton within wi_mant_comfamforprec
integer x = 2066
integer y = 408
integer width = 379
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Generar"
end type

event clicked;String sel, v_formato, v_familia
Integer resp
DataStore dd
Dec{0} reg, registros,conta,row,number,num

if Trim(uo_proveedor.em_codigo.text) = "" then 
	f_mensaje("Generación de precios por familia y formato","Debe introducir un proveedor")
	return
end if

SELECT count(*)
  INTO :num
  FROM comfamforprec
 WHERE comfamforprec.empresa = :codigo_empresa
   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text;

if IsNull(num) then num = 0

if num > 0 then 
	resp = MessageBox("Generación de precios por familia y formato","Este proveedor tiene generados ya algunos precios, ¿desea sobreescribirlos?",Question!,YesNo!,2)
	if resp = 2 then 
		return
	else
		DELETE FROM comfamforprec
		WHERE comfamforprec.empresa = :codigo_empresa
		  AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text;
		if sqlca.sqlcode <> 0 then
			f_mensaje("Borrado de precios en comfamforprec", "Error: "+sqlca.sqlerrtext)
			ROLLBACK;
			return
		end if
	end if
end if

dw_1.retrieve (codigo_empresa, uo_proveedor.em_codigo.text)


sel = " SELECT familias.codigo, formatos.codigo FROM formatos, familias " +&
		" WHERE formatos.empresa = '"+codigo_empresa+"'"+&
		" AND   formatos.empresa = familias.empresa"
		
//dd = f_cargar_cursor (sel)
f_cargar_cursor_nuevo(sel, dd)

registros = dd.RowCount()

for reg = 1 to registros
	v_familia = dd.GetItemString(reg,"familias_codigo")
	v_formato = dd.GetItemString(reg,"formatos_codigo")
	SELECT count(*)
	  INTO :conta
	  FROM comfamforprec
	 WHERE comfamforprec.empresa = :codigo_empresa
	   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text
		AND comfamforprec.familia = :v_familia
		AND comfamforprec.formato = :v_formato;
		
		if IsNull(conta) then conta = 0 
		if conta = 0 then
			SELECT count(*) 
			  INTO :number
			  FROM articulos
			 WHERE articulos.empresa = :codigo_empresa
			   AND articulos.familia = :v_familia
				AND articulos.formato = :v_formato;
			if IsNull(number) then number = 0
			
			if number > 0 then
				// solo damos de alta aquellas parejas de fam y form
				// para las que existan artículos dados de alta
				row = dw_1.InsertRow(0)
				dw_1.SetItem(row,"empresa",codigo_empresa)
				dw_1.SetItem(row,"proveedor",uo_proveedor.em_codigo.text)
				dw_1.SetItem(row,"familia",v_familia)
				dw_1.SetItem(row,"familias_descripcion",f_nombre_familia(codigo_empresa,v_familia))
				dw_1.SetItem(row,"formato",v_formato)
				dw_1.SetItem(row,"formatos_descripcion",f_nombre_formato(codigo_empresa,v_formato))			
				// insertamos primera, y como caso raro podrán insertar
				// segunda manualmente
				dw_1.SetItem(row,"calidad","1")
				dw_1.SetItem(row,"precio_compra",0)
			end if
		end if
			
next
dw_1.Sort()
Destroy dd
end event

type pb_1 from upb_salir within wi_mant_comfamforprec
integer x = 2350
integer y = 136
integer width = 137
integer taborder = 30
boolean bringtotop = true
end type

type cb_procesar from u_boton within wi_mant_comfamforprec
integer x = 2066
integer y = 752
integer width = 370
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F3 Procesar"
end type

event clicked;Dec{0} cont,registros,num
Dec{2} v_precio
String v_familia,v_formato, v_calidad
registros = dw_1.RowCount()
Boolean bien = true

dw_1.AcceptText()

for cont = 1 to registros
	v_familia = dw_1.GetItemString(cont,"familia")
	v_formato = dw_1.GetItemString(cont,"formato")
	v_precio  = dw_1.GetItemNumber(cont,"precio_compra")
	v_calidad = dw_1.GetItemString(cont,"calidad")
	SELECT count(*)
	  INTO :num
	  FROM comfamforprec
	 WHERE comfamforprec.empresa   = :codigo_empresa
	   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text
		AND comfamforprec.familia   = :v_familia
		AND comfamforprec.formato   = :v_formato
		AND comfamforprec.calidad   = :v_calidad;
	
	if IsNull(num) then num = 0
	
	if num = 0 then
		// El registro no existía en la tabla. Lo insertamos
		INSERT INTO comfamforprec (empresa,proveedor,
						familia,formato,calidad,precio_compra)
		VALUES (:codigo_empresa, :uo_proveedor.em_codigo.text,
					:v_familia, :v_formato, :v_calidad,:v_precio);

		if sqlca.sqlcode <> 0 then bien = false
	else
		// El registro ya existía. Actualizamos su precio
		UPDATE comfamforprec
		   SET precio_compra = :v_precio
		 WHERE comfamforprec.empresa   = :codigo_empresa
		   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text
			AND comfamforprec.familia   = :v_familia
			AND comfamforprec.formato   = :v_formato
			AND comfamforprec.calidad   = :v_calidad;
		if sqlca.sqlcode <> 0 then bien = false
		
	end if
			
next

IF bien THEN 
	COMMIT;
else
	ROLLBACK;
end if
end event

type cb_cancelar from u_boton within wi_mant_comfamforprec
integer x = 2066
integer y = 852
integer width = 370
integer height = 84
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "ESC Cancelar"
end type

event clicked;Integer resp

resp = MessageBox("Modificación de precios por formato y familia",&
		"¿Está seguro de que desea cancelar las modificaciones?",Question!,YesNo!,2)

if resp = 2 then
	dw_1.retrieve(codigo_empresa, uo_proveedor.em_codigo.text)
end if
end event

type gb_1 from groupbox within wi_mant_comfamforprec
integer x = 50
integer y = 920
integer width = 2446
integer height = 268
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_2 from statictext within wi_mant_comfamforprec
integer x = 105
integer y = 984
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Familia"
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_comfamforprec
integer x = 832
integer y = 984
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Formato"
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_comfamforprec
integer x = 1339
integer y = 984
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Precio "
boolean focusrectangle = false
end type

type uo_familia from u_em_campo_2 within wi_mant_comfamforprec
integer x = 105
integer y = 1064
integer width = 608
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_familia.em_campo.text =f_nombre_familia( codigo_empresa,uo_familia.em_codigo.Text)
IF Len(uo_familia.em_codigo.Text) = 0 Then
	 uo_familia.em_codigo.text = ""
	 uo_familia.em_campo.text = ""	 
END IF
end event

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_familias"
ue_titulo         = "AYUDA SELECCION DE FAMILIAS"
ue_filtro         = ""
end event

on uo_familia.destroy
call u_em_campo_2::destroy
end on

type uo_formato from u_em_campo_2 within wi_mant_comfamforprec
integer x = 832
integer y = 1064
integer width = 379
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_formatos"
ue_titulo         = "AYUDA SELECCION DE FORMATOS"
ue_filtro         = ""
end event

event modificado;uo_formato.em_campo.text =f_nombre_formato( codigo_empresa,uo_formato.em_codigo.Text)
IF Len(uo_formato.em_codigo.Text) = 0 Then
	 uo_formato.em_codigo.text = ""
	 uo_formato.em_campo.text = ""	 
END IF

uo_calidad.em_codigo.text = "1"
uo_calidad.em_campo.text  = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
end event

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type em_precio from u_em_campo within wi_mant_comfamforprec
integer x = 1339
integer y = 1064
integer width = 320
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "########,00"
end type

type pb_2 from picturebutton within wi_mant_comfamforprec
integer x = 722
integer y = 1064
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_familias"
lstr_param.s_argumentos[2]  = uo_familia.em_codigo.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_familias, lstr_param)
end event

type pb_3 from picturebutton within wi_mant_comfamforprec
integer x = 1216
integer y = 1064
integer width = 110
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_formatos"
lstr_param.s_argumentos[2]  = uo_formato.em_codigo.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_formatos, lstr_param)
end event

type cb_insertar from u_boton within wi_mant_comfamforprec
integer x = 2080
integer y = 976
integer width = 370
integer height = 84
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;uo_familia.em_codigo.text = ""
uo_familia.em_campo.text = ""
uo_formato.em_codigo.text = ""
uo_formato.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
em_precio.text = "0"

f_activar_campo(uo_familia.em_campo)
end event

type cb_grabar from u_boton within wi_mant_comfamforprec
integer x = 2080
integer y = 1076
integer width = 370
integer height = 84
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;// comprobación de campos obligatorios
if IsNull(uo_proveedor.em_codigo.text) or Trim(uo_proveedor.em_codigo.text) = "" then
	f_mensaje("Grabar precio para una familia y formato","Ha de introducir el proveedor")
	f_activar_campo(uo_proveedor.em_campo)
	return
end if

if IsNull(uo_familia.em_codigo.text) or Trim(uo_familia.em_codigo.text) = "" then
	f_mensaje("Grabar precio para una familia y formato","Ha de introducir la familia")
	f_activar_campo(uo_familia.em_campo)
	return
end if

if IsNull(uo_formato.em_codigo.text) or Trim(uo_formato.em_codigo.text) = "" then
	f_mensaje("Grabar precio para una familia y formato","Ha de introducir el formato")
	f_activar_campo(uo_formato.em_campo)
	return
end if

if IsNull(em_precio.text) or Dec(em_precio.text) = 0 then
	f_mensaje("Grabar precio para una familia y formato","Ha de introducir el precio")
	f_activar_campo(em_precio)
	return
end if

if IsNull(uo_calidad.em_codigo.text) or Trim(uo_calidad.em_codigo.text) = "" then
	f_mensaje("Grabar precio para una familia y formato","Ha de introducir la calidad")
	f_activar_campo(uo_calidad.em_campo)
	return
end if

Integer num, resp
Dec precio

SELECT count(*)
  INTO :num
  FROM comfamforprec
 WHERE comfamforprec.empresa = :codigo_empresa
   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text
   AND comfamforprec.familia = :uo_familia.em_codigo.text
	AND comfamforprec.formato = :uo_formato.em_codigo.text
	and comfamforprec.calidad = :uo_calidad.em_codigo.text;
	
if IsNull(num) then num = 0
if num > 0 then 
	resp = MessageBox("Grabar precio para una familia y formato",&
		"Ya existe el precio para esa familia y formato, ¿desea reemplazarlo?",Question!,YesNo!,2)
	if resp = 2 then return
	precio = Dec(em_precio.text)
	UPDATE comfamforprec
	   SET precio_compra = :precio
	 WHERE comfamforprec.empresa = :codigo_empresa
	   AND comfamforprec.proveedor = :uo_proveedor.em_codigo.text
	   AND comfamforprec.familia = :uo_familia.em_codigo.text
	   AND comfamforprec.formato = :uo_formato.em_codigo.text
		AND comfamforprec.calidad = :uo_calidad.em_codigo.text;
		
	if sqlca.sqlcode <> 0 then
		f_mensaje("Actualización del precio","Error: "+sqlca.sqlerrtext)
		ROLLBACK;
	else
		f_mensaje("bien","")
		COMMIT;
	end if
else
	precio = Dec(em_precio.text)	
	INSERT INTO comfamforprec (empresa,proveedor,familia,formato,calidad,precio_compra)
	VALUES (:codigo_empresa, :uo_proveedor.em_codigo.text,&
			:uo_familia.em_codigo.text, :uo_formato.em_codigo.text,&
			:uo_calidad.em_codigo.text,:precio);

	if sqlca.sqlcode <> 0 then
		f_mensaje("Inserción del precio","Error: "+sqlca.sqlerrtext)
		ROLLBACK;
	else
		f_mensaje("bienn","")
		COMMIT;
	end if
	
end if

cb_insertar.TriggerEvent("clicked")
cb_consulta.TriggerEvent("clicked")
end event

type st_5 from statictext within wi_mant_comfamforprec
integer x = 1701
integer y = 984
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Calidad"
boolean focusrectangle = false
end type

type uo_calidad from u_em_campo_2 within wi_mant_comfamforprec
integer x = 1701
integer y = 1064
integer width = 229
integer taborder = 130
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_calidad.em_campo.text =f_nombre_calidad_abr( codigo_empresa,uo_calidad.em_codigo.Text)
IF Len(uo_calidad.em_codigo.Text) = 0 Then
	 uo_calidad.em_codigo.text = ""
	 uo_calidad.em_campo.text = ""	 
END IF


end event

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_calidades"
ue_titulo         = "AYUDA SELECCION DE CALIDADES"
ue_filtro         = ""
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

