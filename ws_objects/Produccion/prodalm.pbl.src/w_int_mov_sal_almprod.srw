$PBExportHeader$w_int_mov_sal_almprod.srw
forward
global type w_int_mov_sal_almprod from w_int_con_empresa
end type
type st_texto_cantidad from statictext within w_int_mov_sal_almprod
end type
type st_9 from statictext within w_int_mov_sal_almprod
end type
type pb_1 from upb_salir within w_int_mov_sal_almprod
end type
type em_cantidad from u_em_campo within w_int_mov_sal_almprod
end type
type sle_observaciones from u_em_campo within w_int_mov_sal_almprod
end type
type cb_1 from u_boton within w_int_mov_sal_almprod
end type
type uo_articulo from u_em_campo_2 within w_int_mov_sal_almprod
end type
type cb_5 from commandbutton within w_int_mov_sal_almprod
end type
type st_1 from statictext within w_int_mov_sal_almprod
end type
type st_texto_5 from statictext within w_int_mov_sal_almprod
end type
type em_f_alta from u_em_campo within w_int_mov_sal_almprod
end type
type dw_1 from datawindow within w_int_mov_sal_almprod
end type
end forward

global type w_int_mov_sal_almprod from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2917
integer height = 1324
string icon = "\bmp\RINO.ICO"
st_texto_cantidad st_texto_cantidad
st_9 st_9
pb_1 pb_1
em_cantidad em_cantidad
sle_observaciones sle_observaciones
cb_1 cb_1
uo_articulo uo_articulo
cb_5 cb_5
st_1 st_1
st_texto_5 st_texto_5
em_f_alta em_f_alta
dw_1 dw_1
end type
global w_int_mov_sal_almprod w_int_mov_sal_almprod

type variables
//str_parametros  istr_parametros
   integer contador,v_altura,v_fila,anyo
  decimal{4} v_cantidad
  decimal{4} ante_valor, ante_cant
  String v_almacen,v_zona,cod_sector
  string ante_numdoc
  String situado
  Boolean  control_tono,control_calibre
// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis       mov
// Especial: modificación de entradas
Boolean especial = false



end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Movimientos Salidas Formulas"
This.title=istr_parametros.s_titulo_ventana

dw_1.Settransobject(SQLCA)

em_f_alta.text = string(today(),"dd/mm/yy")
uo_articulo.em_campo.text = ""
uo_articulo.em_codigo.text = ""
em_cantidad.text = ""
sle_observaciones.text = ""
dw_1.visible = false
uo_articulo.em_campo.setfocus()


end event

on w_int_mov_sal_almprod.create
int iCurrent
call super::create
this.st_texto_cantidad=create st_texto_cantidad
this.st_9=create st_9
this.pb_1=create pb_1
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.cb_5=create cb_5
this.st_1=create st_1
this.st_texto_5=create st_texto_5
this.em_f_alta=create em_f_alta
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_texto_cantidad
this.Control[iCurrent+2]=this.st_9
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.em_cantidad
this.Control[iCurrent+5]=this.sle_observaciones
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_texto_5
this.Control[iCurrent+11]=this.em_f_alta
this.Control[iCurrent+12]=this.dw_1
end on

on w_int_mov_sal_almprod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_texto_cantidad)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.st_texto_5)
destroy(this.em_f_alta)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_mov_sal_almprod
integer x = 773
integer y = 156
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_mov_sal_almprod
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_mov_sal_almprod
integer width = 2656
end type

type st_texto_cantidad from statictext within w_int_mov_sal_almprod
integer x = 827
integer y = 196
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_mov_sal_almprod
integer x = 224
integer y = 376
integer width = 439
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_mov_sal_almprod
integer x = 2702
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
alignment htextalign = right!
end type

type em_cantidad from u_em_campo within w_int_mov_sal_almprod
integer x = 827
integer y = 272
integer width = 384
integer taborder = 40
integer textsize = -9
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;long indice,total
real cantidad_total

total = dw_1.rowcount()
for indice = 1 to total
	dw_1.setitem(indice,"cantidad_linea",0)
next

if this.text <>"" then
	cantidad_total = real(this.text)
	if  total > 0 then
		if dw_1.getitemnumber(1,"cantidad_total") < cantidad_total then
			this.text = string(dw_1.getitemnumber(1,"cantidad_total"))
			cantidad_total = real(this.text)
		end if
		indice = 1
		do
			if dw_1.getitemnumber(indice,"prodformlinubica_existencias") >= cantidad_total then
				dw_1.setitem(indice,"cantidad_linea",cantidad_total)
				cantidad_total = 0
			else
				dw_1.setitem(indice,"cantidad_linea",dw_1.getitemnumber(indice,"prodformlinubica_existencias"))
				cantidad_total = cantidad_total - dw_1.getitemnumber(indice,"prodformlinubica_existencias")
			end if
			indice = indice + 1
		loop until cantidad_total = 0
	else	
		messagebox("Atención","No existe stock de esta formula en almacen")
		em_cantidad.text = "0"
		uo_articulo.em_codigo.setfocus()
	end if
end if
end event

type sle_observaciones from u_em_campo within w_int_mov_sal_almprod
integer x = 718
integer y = 376
integer width = 1847
integer taborder = 50
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;situado= "OBSERVACIONES"
end event

type cb_1 from u_boton within w_int_mov_sal_almprod
integer x = 1550
integer y = 268
integer width = 402
integer height = 88
integer taborder = 60
string text = "&Procesar"
end type

event clicked;//CONTROLES DE VALORES
long indice,total
real v_cantidad_linea,v_linea,v_existencias,quedan
int bien = 0
string mensaje,v_formula,v_observaciones
int v_anyo 
datetime	v_fecha 

dw_1.accepttext()

IF trim(em_f_alta.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_f_alta.SetFocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca la formula"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

IF trim(em_cantidad.text)="" THEN
   mensaje="Introduzca la cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

if real(em_cantidad.text) <> dw_1.getitemnumber(1,"cantidad_total_salida") then
	messagebox("Atención","La cantidad de salida no coincide con la de ubicaciones")
	em_cantidad.setfocus()
else	
	total = dw_1.rowcount()
	for indice = 1 to total
		v_cantidad_linea = dw_1.getitemnumber(indice,"cantidad_linea")
		if v_cantidad_linea > 0 then
			v_linea = dw_1.getitemnumber(indice,"prodformlinubica_linea")
			v_existencias = dw_1.getitemnumber(indice,"prodformlinubica_existencias")
			if v_existencias = v_cantidad_linea then
				delete from prodformlinubica
				where empresa = :codigo_empresa
				and linea = :v_linea;
				
				IF SQLCA.SQLCODE <> 0 Then
					f_mensaje("Error en base de datos (Función Salidas almacen)",sqlca.sqlerrtext)
					bien = 1
				END IF
			else
				quedan = v_existencias - v_cantidad_linea
				update prodformlinubica
				set existencias = :quedan
				where empresa = :codigo_empresa
				and linea = :v_linea;
				
				IF SQLCA.SQLCODE <> 0 Then
					f_mensaje("Error en base de datos (Función Salidas almacen)",sqlca.sqlerrtext)
					bien = 1
				END IF				
			end if
		end if
	next
	v_anyo = year(date(em_f_alta.text))
	v_fecha = datetime(date(em_f_alta.text))
	v_formula = uo_articulo.em_codigo.text
	v_cantidad = real(em_cantidad.text)
	v_observaciones = sle_observaciones.text
	v_linea = f_linea_his_form (codigo_empresa,v_anyo)
	insert into prodmovformhis
	(empresa,anyo,linea,
	fecha,formula,
	cantidad,observaciones,
	entrada_salida)
	values
	(:codigo_empresa,:v_anyo,:v_linea,
	:v_fecha,:v_formula,
	:v_cantidad,:v_observaciones,
	"S");
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error en base de datos inserción prodmovforhis",sqlca.sqlerrtext)
		bien = 1
	END IF				
	
	IF bien = 1 Then
		rollback;
		uo_articulo.em_campo.setfocus()
	ELSE
		commit;
		em_f_alta.text = string(today(),"dd/mm/yy")
		uo_articulo.em_campo.text = ""
		uo_articulo.em_codigo.text = ""
		em_cantidad.text = ""
		sle_observaciones.text = ""
		dw_1.visible = false
		uo_articulo.em_campo.setfocus()
	END IF

end if	


end event

type uo_articulo from u_em_campo_2 within w_int_mov_sal_almprod
integer x = 18
integer y = 272
integer width = 809
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_articulo.em_campo.text = Trim(f_nombre_formulacion_produccion(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
ELSE
	dw_1.retrieve (codigo_empresa , uo_articulo.em_codigo.text)
	dw_1.visible = true
END IF

end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodformulaciones"
ue_titulo      = "AYUDA SELECCION DE FORMULACIONES"
ue_filtro      =""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_5 from commandbutton within w_int_mov_sal_almprod
integer x = 18
integer y = 196
integer width = 805
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_formulaciones, lstr_param)
end event

type st_1 from statictext within w_int_mov_sal_almprod
integer x = 283
integer y = 200
integer width = 288
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "formula"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type st_texto_5 from statictext within w_int_mov_sal_almprod
integer x = 1216
integer y = 196
integer width = 306
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_f_alta from u_em_campo within w_int_mov_sal_almprod
integer x = 1221
integer y = 272
integer width = 306
integer taborder = 20
boolean bringtotop = true
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_1 from datawindow within w_int_mov_sal_almprod
integer x = 23
integer y = 484
integer width = 2825
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_int_almlinubiprod_sal"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

