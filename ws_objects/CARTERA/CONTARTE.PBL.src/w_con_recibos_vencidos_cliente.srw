$PBExportHeader$w_con_recibos_vencidos_cliente.srw
$PBExportComments$€
forward
global type w_con_recibos_vencidos_cliente from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_vencidos_cliente
end type
type uo_tipo from u_marca_lista within w_con_recibos_vencidos_cliente
end type
type cb_consulta from u_boton within w_con_recibos_vencidos_cliente
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_cliente
end type
type dw_listado from datawindow within w_con_recibos_vencidos_cliente
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_vencidos_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_recibos_vencidos_cliente
end type
type dw_1 from datawindow within w_con_recibos_vencidos_cliente
end type
type em_fecha from u_em_campo within w_con_recibos_vencidos_cliente
end type
type detalle from radiobutton within w_con_recibos_vencidos_cliente
end type
type resumen from radiobutton within w_con_recibos_vencidos_cliente
end type
type gb_4 from groupbox within w_con_recibos_vencidos_cliente
end type
type gb_3 from groupbox within w_con_recibos_vencidos_cliente
end type
type gb_2 from groupbox within w_con_recibos_vencidos_cliente
end type
type gb_1 from groupbox within w_con_recibos_vencidos_cliente
end type
type gb_cuenta from groupbox within w_con_recibos_vencidos_cliente
end type
type gb_fecha from groupbox within w_con_recibos_vencidos_cliente
end type
type rb_v from radiobutton within w_con_recibos_vencidos_cliente
end type
type rb_n from radiobutton within w_con_recibos_vencidos_cliente
end type
type rb_t from radiobutton within w_con_recibos_vencidos_cliente
end type
type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_cliente
end type
end forward

global type w_con_recibos_vencidos_cliente from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 2296
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_tipo uo_tipo
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
uo_cliente uo_cliente
dw_1 dw_1
em_fecha em_fecha
detalle detalle
resumen resumen
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_cuenta gb_cuenta
gb_fecha gb_fecha
rb_v rb_v
rb_n rb_n
rb_t rb_t
uo_1 uo_1
end type
global w_con_recibos_vencidos_cliente w_con_recibos_vencidos_cliente

type variables
String det = "S"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros,r,contador = 0
Dec anyofra,f,anteanyofra,numero,lnfra,dif,dias,dif1,dias1,pendiente1,impcobrado1,importe1,importe,pendiente,impcobrado,lncli,pendiente2,impcobrado2,importe2,dias2,dif2,dif3,dias3,importe3,impcobrado3,pendiente3,lntot
DateTime fecha,ffra,fvto
String cli1,cli2,sel,factura,antefra,nombre_cliente,cli,antecli,antenomcli
DataStore dw
DataStore dw2
lnfra = 0
lntot = 0
dw_data.reset()
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
antefra = ""
cli = ""
//dw_data.modify("cab.Nest_Arguments=(('~""+codigo_empresa+"~"'))")
//dw_data.Modify ("DataWindow.Print.Preview=Yes")
//dw_data.Retrieve()
//
//if tipo_vista="Nacional" then fi="(nacional='S')"
//if tipo_vista="Exportacion" then fi="(nacional='N')"
//if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"

iF Trim(uo_cliente.em_codigo.text) = "" Then
   cli1 = "."
   cli2 = "Z"
ELSE
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF

int cual
fecha=Datetime(Date(String(em_fecha.Text)))
string ff
if rb_v.checked then cual=1
if rb_n.checked then cual=2
if rb_t.checked then cual=3
choose case cual
	case 1
		ff=" And    fvto < '"+ STring(Date(fecha),"dd/mm/yyyy")+"'"
	case 2
		ff=" And    fvto >= '"+ STring(Date(fecha),"dd/mm/yyyy")+"'" 
	case 3
		ff=""		
end choose

sel = " Select cliente,ffra,fvto,factura,anyofra,recibo,tipodoc,importe,divisas,monedas "+&
" From   carefectos "+&
" Where  empresa ='" +codigo_empresa+"'"+&
" And    cliente between '"+ cli1 + "' and '"+ cli2 +"'"+&
" And    situacion Not In('2','3')" + ff + &
"order by cliente,anyofra,factura"

//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
dw_data.SetRedraw(FALSE)
impcobrado1 = 0
pendiente1 = 0
importe1 = 0
impcobrado2 = 0
pendiente2 = 0
importe2 = 0
lnfra = 0
lncli = 0
if dw.rowcount()=0 then 
	destroy dw
	return
end if
For r = 1 To dw.rowCOunt()


	factura = dw.GetItemString(r,"factura")
	anyofra = dw.GetItemNumber(r,"anyofra")
	ffra    = dw.GetItemDateTime(r,"ffra")
	fvto    = dw.GetItemDateTime(r,"fvto")
	cli     = dw.GetItemString(r,"cliente")
	iF r = 1 Then nombre_cliente= f_razon_genter(codigo_empresa,"C",cli)
	
// cambio de fra	
IF antefra <> "" and antefra <> factura Then	
	Select count(*) Into :numero From   carhistorico 
   Where  empresa = :codigo_empresa
	And    anyofra = :anteanyofra
	And    factura = :antefra 
	And    situacion ='9';
	IF IsNull(numero) Then numero = 0
	IF numero <> 0 Then
			sel = " Select factura,cliente,ffra,fvto,recibo,tipodoc,importe,divisas,monedas,fcobro "+&
			" From   carhistorico "+&
			" Where  empresa ='" +codigo_empresa+"'"+&
			" And    anyofra ="+ String(anteanyofra,"####")+&
			" And    factura ='"+ antefra +"'"+&
			" And    situacion ='9'"

			//dw2 = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, dw2)
			For f = 1 To dw2.rowCOunt()
					// contador lineas por fra
					lnfra = lnfra +1
					lntot = lntot +1
					lncli = lncli +1
					dif   = Dec(String(daysafter( date(dw2.GetItemDateTime(f,"fvto")),date(dw2.GetItemDateTime(f,"fcobro"))),f_mascara_decimales(0)))
					dias  = Dec(String(daysafter( date(dw2.GetItemDateTime(f,"ffra")),date(dw2.GetItemDateTime(f,"fvto")) ),f_mascara_decimales(0)))
					dias1 = dias1 + dias
					dif1  = dif1   + dif
					dias2 = dias2 + dias
					dif2  = dif2   + dif	
					dias3 = dias3 + dias
					dif3  = dif3   + dif
					importe = dw2.GetItemNumber(f,"importe")
					importe1 = importe1 + importe
					importe2 = importe2 + importe
					importe3 = importe3 + importe
					impcobrado1 = impcobrado1 + importe
					impcobrado2 = impcobrado2 + importe
					impcobrado3 = impcobrado3 + importe
					IF det = "S" Then
							contador = contador +1
							dw_data.InsertRow(contador)
							dw_data.SetItem(contador,"empresa",codigo_empresa)
							dw_data.SetItem(contador,"detalle",det)
							dw_data.SetItem(contador,"cliente",nombre_cliente)
							dw_data.SetItem(contador,"ffra",dw2.GetItemDateTime(f,"ffra"))
							dw_data.SetItem(contador,"fvto",dw2.GetItemDateTime(f,"fvto"))
							dw_data.SetItem(contador,"tipodoc",f_nombre_cartipodoc(codigo_empresa,dw.GetItemString(f,"tipodoc")))
							dw_data.SetItem(contador,"factura",dw2.GetItemString(f,"factura"))
							dw_data.SetItem(contador,"fcobro",dw2.GetItemDateTime(f,"fcobro"))					
							dw_data.SetItem(contador,"dias",dias)
							dw_data.SetItem(contador,"dif",dif)
							dw_data.SetItem(contador,"importe",importe)
							dw_data.SetItem(contador,"impcobrado",importe)
							dw_data.SetItem(contador,"recibo",dw2.GetItemNumber(f,"recibo"))
							dw_data.SetItem(contador,"cobrado","S")
							dw_data.SetItem(contador,"fecha",fecha)
							dw_data.SetItem(contador,"tipo",1)
					END IF
				NExt
		END IF
		IF det = "S" Then
				// Despues de cada factura
				IF lnfra > 1 Then
					contador = contador +1
					dw_data.InsertRow(contador)
					dw_data.SetItem(contador,"empresa",codigo_empresa)
					dw_data.SetItem(contador,"detalle",det)					
					dw_data.SetItem(contador,"dias",Dec(String(dias1/lnfra,f_mascara_decimales(0))))
					dw_data.SetItem(contador,"dif",Dec(String(dif1/lnfra,f_mascara_decimales(0))))
					dw_data.SetItem(contador,"importe",importe1)			
					dw_data.SetItem(contador,"pendiente",pendiente1)			
					dw_data.SetItem(contador,"impcobrado",impcobrado1)			
					dw_data.SetItem(contador,"tipo",2)
				END IF
		END IF
		dias1 = 0
		dif1  = 0
		pendiente1   = 0
		impcobrado1  = 0
		importe1     = 0
		lnfra        = 0
END IF

	IF antecli <> "" and antecli <> cli Then
		// Despues de cada cliente
			contador = contador +1
   		dw_data.InsertRow(contador)
			dw_data.SetItem(contador,"empresa",codigo_empresa)
			dw_data.SetItem(contador,"detalle",det)			
			dw_data.SetItem(contador,"dias",Dec(String(dias2/lncli,f_mascara_decimales(0))))
			dw_data.SetItem(contador,"dif",Dec(String(dif2/lncli,f_mascara_decimales(0))))
			dw_data.SetItem(contador,"importe",importe2)			
			dw_data.SetItem(contador,"pendiente",pendiente2)			
			dw_data.SetItem(contador,"impcobrado",impcobrado2)			
			IF det = "S" Then
				dw_data.SetItem(contador,"tipo",2)
			ELSE
				dw_data.SetItem(contador,"tipo",1)
			END IF

			dw_data.SetItem(contador,"texto",nombre_cliente)
			iF det = "S" Then
				contador = contador +1
				dw_data.InsertRow(contador)
				dw_data.SetItem(contador,"empresa",codigo_empresa)
				dw_data.SetItem(contador,"detalle",det)				
				dw_data.SetItem(contador,"tipo",3)
			END IF
			dias2 = 0
			dif2  = 0
			pendiente2   = 0
			impcobrado2  = 0
			importe2     = 0
			lncli       = 0
			nombre_cliente= f_razon_genter(codigo_empresa,"C",cli)
	END IF

	// contador lineas por fra
	lnfra = lnfra +1
	lncli = lncli +1				
	lntot = lntot +1
	dias  = Dec(String(daysafter(Date(dw.GetItemDateTime(r,"ffra")),date(dw.GetItemDateTime(r,"fvto"))) ,f_mascara_decimales(0)))
	dif   = Dec(String(daysafter( date(dw.GetItemDateTime(r,"fvto")),date(fecha)),f_mascara_decimales(0)))
	dias1 = dias1  + dias
	dif1  = dif1   + dif	
	dias2 = dias2  + dias
	dif2  = dif2   + dif
	dias3 = dias3  + dias
	dif3  = dif3   + dif
	importe = dw.GetItemNumber(r,"importe")
	importe1 = importe1 + importe
	pendiente1 = pendiente1 + importe
	importe2 = importe2 + importe
	pendiente2 = pendiente2 + importe
	importe3 = importe3 + importe
	pendiente3 = pendiente3 + importe
	IF det = "S" Then
			contador = contador +1
			dw_data.InsertRow(contador)
			dw_data.SetItem(contador,"empresa",codigo_empresa)
			dw_data.SetItem(contador,"detalle",det)			
			dw_data.SetItem(contador,"tipo",1)
			dw_data.SetItem(contador,"cliente",nombre_cliente)
			dw_data.SetItem(contador,"ffra",ffra)
			dw_data.SetItem(contador,"fvto",dw.GetItemDateTime(r,"fvto"))
			dw_data.SetItem(contador,"dias",dias)
			dw_data.SetItem(contador,"dif",dif)
			dw_data.SetItem(contador,"tipodoc",f_nombre_cartipodoc(codigo_empresa,dw.GetItemString(r,"tipodoc")))
			dw_data.SetItem(contador,"factura",factura)
			dw_data.SetItem(contador,"importe",importe)
			dw_data.SetItem(contador,"pendiente",importe)
			dw_data.SetItem(contador,"recibo",dw.GetItemNumber(r,"recibo"))
			dw_data.SetItem(contador,"cobrado","N")
			dw_data.SetItem(contador,"fecha",fecha)
	END IF
	f_mensaje_proceso("Espere Por favor",r,dw.rowCount())
	
			
	antefra = factura
	anteanyofra = anyofra
	antecli = cli
	COMMIT;
NEXT
IF det = "S" Then
		// Ultina factura
		IF lnfra > 1 Then
			contador = contador +1
			dw_data.InsertRow(contador)
			dw_data.SetItem(contador,"empresa",codigo_empresa)
			dw_data.SetItem(contador,"detalle",det)			
			dw_data.SetItem(contador,"dias",Dec(String(dias1/lnfra,f_mascara_decimales(0))))
			dw_data.SetItem(contador,"dif",Dec(String(dif1/lnfra,f_mascara_decimales(0))))
			dw_data.SetItem(contador,"importe",importe1)			
			dw_data.SetItem(contador,"pendiente",pendiente1)			
			dw_data.SetItem(contador,"impcobrado",impcobrado1)			
			dw_data.SetItem(contador,"tipo",2)
		END IF
END IF

// Ultimo Cliente
	contador = contador +1
	dw_data.InsertRow(contador)
	dw_data.SetItem(contador,"empresa",codigo_empresa)
	dw_data.SetItem(contador,"detalle",det)				
	dw_data.SetItem(contador,"dias",Dec(String(dias2/lncli,f_mascara_decimales(0))))
	dw_data.SetItem(contador,"dif",Dec(String(dif2/lncli,f_mascara_decimales(0))))
	dw_data.SetItem(contador,"importe",importe2)			
	dw_data.SetItem(contador,"pendiente",pendiente2)			
	dw_data.SetItem(contador,"impcobrado",impcobrado2)			
	IF det = "S" Then
		dw_data.SetItem(contador,"tipo",2)
	ELSE
		dw_data.SetItem(contador,"tipo",1)
	END IF
	dw_data.SetItem(contador,"texto",nombre_cliente)
	
	
	
// Total
	contador = contador +1
	dw_data.InsertRow(contador)
	dw_data.SetItem(contador,"empresa",codigo_empresa)
	dw_data.SetItem(contador,"detalle",det)			
	dw_data.SetItem(contador,"dias",Dec(String(dias3/lntot,f_mascara_decimales(0))))
	dw_data.SetItem(contador,"dif",Dec(String(dif3/lntot,f_mascara_decimales(0))))
	dw_data.SetItem(contador,"importe",importe3)			
	dw_data.SetItem(contador,"pendiente",pendiente3)			
	dw_data.SetItem(contador,"impcobrado",impcobrado3)			
	dw_data.SetItem(contador,"tipo",2)
	dw_data.SetItem(contador,"texto","                         TOTAL")


f_mensaje_proceso("Espere Por favor",99,100)
dw_data.SetRedraw(TRUE)
f_mensaje_proceso("Espere Por favor",100,100)
COMMIT;

destroy dw
destroy dw2
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta recibos vencidos por cliente"
dw_1.Setfocus()
em_fecha.text = String(Today())
f_activar_campo(uo_cliente.em_campo)


end event

on w_con_recibos_vencidos_cliente.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_tipo=create uo_tipo
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.uo_cliente=create uo_cliente
this.dw_1=create dw_1
this.em_fecha=create em_fecha
this.detalle=create detalle
this.resumen=create resumen
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_cuenta=create gb_cuenta
this.gb_fecha=create gb_fecha
this.rb_v=create rb_v
this.rb_n=create rb_n
this.rb_t=create rb_t
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_tipo
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_tipo2
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.detalle
this.Control[iCurrent+11]=this.resumen
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_cuenta
this.Control[iCurrent+17]=this.gb_fecha
this.Control[iCurrent+18]=this.rb_v
this.Control[iCurrent+19]=this.rb_n
this.Control[iCurrent+20]=this.rb_t
this.Control[iCurrent+21]=this.uo_1
end on

on w_con_recibos_vencidos_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_tipo)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.uo_cliente)
destroy(this.dw_1)
destroy(this.em_fecha)
destroy(this.detalle)
destroy(this.resumen)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_cuenta)
destroy(this.gb_fecha)
destroy(this.rb_v)
destroy(this.rb_n)
destroy(this.rb_t)
destroy(this.uo_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_vencidos_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_vencidos_cliente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_vencidos_cliente
integer x = 14
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_con_recibos_vencidos_cliente
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_tipo from u_marca_lista within w_con_recibos_vencidos_cliente
boolean visible = false
integer x = 1413
integer y = 316
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_consulta from u_boton within w_con_recibos_vencidos_cliente
integer x = 1403
integer y = 132
integer width = 160
integer height = 152
integer taborder = 80
string text = "&Ok"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_cliente.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_cliente
integer x = 2720
integer y = 192
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_cliente.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_vencidos_cliente
boolean visible = false
integer x = 274
integer y = 76
integer width = 539
integer height = 92
string dataobject = "report_con_carefectos_vencidos_cliente"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_recibos_vencidos_cliente
boolean visible = false
integer x = 242
integer y = 320
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_recibos_vencidos_cliente
event destroy ( )
integer x = 393
integer y = 180
integer width = 955
integer height = 80
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"


end event

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_1.Reset()

end event

type dw_1 from datawindow within w_con_recibos_vencidos_cliente
integer y = 308
integer width = 2871
integer height = 1764
boolean bringtotop = true
string dataobject = "dw_con_carefectos_vencidos_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

type em_fecha from u_em_campo within w_con_recibos_vencidos_cliente
integer x = 37
integer y = 184
integer width = 283
integer height = 80
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type detalle from radiobutton within w_con_recibos_vencidos_cliente
integer x = 1938
integer y = 148
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
end type

event clicked;det = "S"
end event

type resumen from radiobutton within w_con_recibos_vencidos_cliente
integer x = 1938
integer y = 212
integer width = 293
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Resum."
end type

event clicked;det = "N"
end event

type gb_4 from groupbox within w_con_recibos_vencidos_cliente
integer x = 1385
integer y = 88
integer width = 197
integer height = 208
integer taborder = 1
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_con_recibos_vencidos_cliente
integer x = 1915
integer y = 88
integer width = 338
integer height = 208
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_recibos_vencidos_cliente
integer x = 1582
integer y = 88
integer width = 334
integer height = 208
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_recibos_vencidos_cliente
integer x = 1925
integer y = 124
integer width = 283
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_cuenta from groupbox within w_con_recibos_vencidos_cliente
integer x = 352
integer y = 124
integer width = 1033
integer height = 172
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Cliente"
end type

type gb_fecha from groupbox within w_con_recibos_vencidos_cliente
integer y = 124
integer width = 352
integer height = 172
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fecha"
end type

type rb_v from radiobutton within w_con_recibos_vencidos_cliente
event clicked pbm_bnclicked
integer x = 1595
integer y = 128
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Venc."
end type

type rb_n from radiobutton within w_con_recibos_vencidos_cliente
event clicked pbm_bnclicked
integer x = 1595
integer y = 184
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Venc."
end type

type rb_t from radiobutton within w_con_recibos_vencidos_cliente
event clicked pbm_bnclicked
integer x = 1595
integer y = 240
integer width = 306
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
end type

type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_cliente
integer x = 2245
integer y = 148
end type

event valores;call super::valores;dw_data = dw_1

end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

