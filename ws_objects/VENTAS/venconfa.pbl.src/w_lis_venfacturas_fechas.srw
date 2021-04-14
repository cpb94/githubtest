$PBExportHeader$w_lis_venfacturas_fechas.srw
forward
global type w_lis_venfacturas_fechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venfacturas_fechas
end type
type st_2 from statictext within w_lis_venfacturas_fechas
end type
type em_fecha1 from u_em_campo within w_lis_venfacturas_fechas
end type
type em_fecha2 from u_em_campo within w_lis_venfacturas_fechas
end type
type dw_proceso from datawindow within w_lis_venfacturas_fechas
end type
type dw_preliminar from datawindow within w_lis_venfacturas_fechas
end type
type em_copias1 from editmask within w_lis_venfacturas_fechas
end type
type cb_2 from u_boton within w_lis_venfacturas_fechas
end type
type st_13 from statictext within w_lis_venfacturas_fechas
end type
type uo_1 from u_selec_impresoras within w_lis_venfacturas_fechas
end type
type st_6 from statictext within w_lis_venfacturas_fechas
end type
type st_22 from statictext within w_lis_venfacturas_fechas
end type
type em_serie from u_em_campo within w_lis_venfacturas_fechas
end type
type st_nombre_serie from statictext within w_lis_venfacturas_fechas
end type
type cabecera from dropdownlistbox within w_lis_venfacturas_fechas
end type
type gb_4 from groupbox within w_lis_venfacturas_fechas
end type
type st_4 from statictext within w_lis_venfacturas_fechas
end type
type em_fra1 from u_em_campo within w_lis_venfacturas_fechas
end type
type st_5 from statictext within w_lis_venfacturas_fechas
end type
type em_fra2 from u_em_campo within w_lis_venfacturas_fechas
end type
type matricial from checkbox within w_lis_venfacturas_fechas
end type
type st_3 from statictext within w_lis_venfacturas_fechas
end type
type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas_fechas
end type
type gb_3 from groupbox within w_lis_venfacturas_fechas
end type
end forward

global type w_lis_venfacturas_fechas from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3840
integer height = 3276
pb_1 pb_1
st_2 st_2
em_fecha1 em_fecha1
em_fecha2 em_fecha2
dw_proceso dw_proceso
dw_preliminar dw_preliminar
em_copias1 em_copias1
cb_2 cb_2
st_13 st_13
uo_1 uo_1
st_6 st_6
st_22 st_22
em_serie em_serie
st_nombre_serie st_nombre_serie
cabecera cabecera
gb_4 gb_4
st_4 st_4
em_fra1 em_fra1
st_5 st_5
em_fra2 em_fra2
matricial matricial
st_3 st_3
cbx_declaracion_entrada_entrega_intracom cbx_declaracion_entrada_entrega_intracom
gb_3 gb_3
end type
global w_lis_venfacturas_fechas w_lis_venfacturas_fechas

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 28
integer lnpie,contador,var_tipo
Integer reg,reg1,ante_anyo_albaran
Dec ante_albaran,var_anyo,v_anyo_albaran,v_albaran,var_factura
DateTime v_falbaran,var_ffactura
String  cc = "1"
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Facturas entre fechas"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
em_fecha1.text = String(Today(),"dd-mm-yy")
em_fecha2.text = String(Today(),"dd-mm-yy")
var_tipo = 1

cabecera.text = "No"
istr_parametros = Message.PowerObjectParm
f_activar_campo(em_serie)




end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_lis_venfacturas_fechas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_fecha1=create em_fecha1
this.em_fecha2=create em_fecha2
this.dw_proceso=create dw_proceso
this.dw_preliminar=create dw_preliminar
this.em_copias1=create em_copias1
this.cb_2=create cb_2
this.st_13=create st_13
this.uo_1=create uo_1
this.st_6=create st_6
this.st_22=create st_22
this.em_serie=create em_serie
this.st_nombre_serie=create st_nombre_serie
this.cabecera=create cabecera
this.gb_4=create gb_4
this.st_4=create st_4
this.em_fra1=create em_fra1
this.st_5=create st_5
this.em_fra2=create em_fra2
this.matricial=create matricial
this.st_3=create st_3
this.cbx_declaracion_entrada_entrega_intracom=create cbx_declaracion_entrada_entrega_intracom
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_fecha1
this.Control[iCurrent+4]=this.em_fecha2
this.Control[iCurrent+5]=this.dw_proceso
this.Control[iCurrent+6]=this.dw_preliminar
this.Control[iCurrent+7]=this.em_copias1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.st_13
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_22
this.Control[iCurrent+13]=this.em_serie
this.Control[iCurrent+14]=this.st_nombre_serie
this.Control[iCurrent+15]=this.cabecera
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.em_fra1
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.em_fra2
this.Control[iCurrent+21]=this.matricial
this.Control[iCurrent+22]=this.st_3
this.Control[iCurrent+23]=this.cbx_declaracion_entrada_entrega_intracom
this.Control[iCurrent+24]=this.gb_3
end on

on w_lis_venfacturas_fechas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_fecha1)
destroy(this.em_fecha2)
destroy(this.dw_proceso)
destroy(this.dw_preliminar)
destroy(this.em_copias1)
destroy(this.cb_2)
destroy(this.st_13)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_22)
destroy(this.em_serie)
destroy(this.st_nombre_serie)
destroy(this.cabecera)
destroy(this.gb_4)
destroy(this.st_4)
destroy(this.em_fra1)
destroy(this.st_5)
destroy(this.em_fra2)
destroy(this.matricial)
destroy(this.st_3)
destroy(this.cbx_declaracion_entrada_entrega_intracom)
destroy(this.gb_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venfacturas_fechas
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venfacturas_fechas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venfacturas_fechas
integer x = 14
integer y = 8
integer width = 3570
integer height = 84
end type

type pb_1 from upb_salir within w_lis_venfacturas_fechas
integer x = 3621
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_2 from statictext within w_lis_venfacturas_fechas
integer x = 1755
integer y = 160
integer width = 142
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Fra:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha1 from u_em_campo within w_lis_venfacturas_fechas
integer x = 1902
integer y = 144
integer width = 265
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fecha2 from u_em_campo within w_lis_venfacturas_fechas
integer x = 2203
integer y = 144
integer width = 274
integer taborder = 30
string text = "    "
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type dw_proceso from datawindow within w_lis_venfacturas_fechas
boolean visible = false
integer x = 2624
integer y = 40
integer width = 494
integer height = 60
boolean bringtotop = true
string dataobject = "dw_proceso_venlifac_dto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preliminar from datawindow within w_lis_venfacturas_fechas
boolean visible = false
integer x = 46
integer y = 432
integer width = 3685
integer height = 2588
boolean bringtotop = true
string dataobject = "report_list_venfacturas1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_copias1 from editmask within w_lis_venfacturas_fechas
integer x = 2423
integer y = 316
integer width = 174
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = " ~v¼~rpbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type cb_2 from u_boton within w_lis_venfacturas_fechas
event clicked pbm_bnclicked
integer x = 3168
integer y = 304
integer width = 553
integer height = 96
integer taborder = 80
string text = "&Imprimir"
end type

event clicked;DateTime fecha1,fecha2
String   sel,cri
Dec r,r1,anyo,fra

IF Trim(em_serie.text) = "" Then
	f_mensaje("Campo Obligarorio","Introduzca la serie")
	f_activar_campo(em_serie)
	Return
END IF

dw_preliminar.DataObject = "report_list_venfacturas1"
dw_preliminar.visible= FALSE
IF em_copias1.text = "0" or Trim(em_copias1.text) = "" Then
	em_copias1.text = "1"
END IF



fecha1 = DateTime(date(em_fecha1.text))
fecha2 = DateTime(date(em_fecha2.text))

IF integer(em_fra1.text) = 0  and integer(em_fra2.text) = 0 Then
	cri = ""
ELSE
	cri = " And    factura >= "+String(Dec(em_fra1.text),"#######0")+" and factura <="+String(Dec(em_fra2.text),"######0")
	
END IF
sel = " Select anyo,factura From venfac " + &
      " Where  serie = '"+Trim(em_serie.text) +"'"+&
		" And    empresa ='"+codigo_empresa + "'"+&
		" And    ffactura >= '"+String(Date(fecha1),"dd/mm/yyyy")+"' and ffactura <='"+String(Date(fecha2),"dd/mm/yyyy")+"'" + &
		cri +&		
      " ANd    actualizada  IN('S','N',null)"+&
		" Order By anyo,factura"
DataStore  dw
//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
r1 = dw.RowCOunt()
dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
iF r1 = 0 Then 
	destroy dw
	Return
end if
For r = 1 to r1
	//yield()
	anyo = dw.getItemNumber(r,"anyo")
	fra = dw.getItemNumber(r,"factura")
	f_mensaje_proceso("Fra: " + STring(fra,f_mascara_decimales(0)),r,r1)
//   f_proceso(1,anyo,fra)
	str_parametros lstr_param
	lstr_param.i_nargumentos   = 8
	lstr_param.s_argumentos[2] = String(anyo,"#######")
	lstr_param.s_argumentos[3] = String(fra,"##########")
	lstr_param.s_argumentos[4] = cabecera.text
	lstr_param.s_argumentos[5] = em_copias1.text
	lstr_param.s_argumentos[6] = uo_1.sle_impresora.text
	
	if matricial.checked then
		lstr_param.s_argumentos[7] = "S"
	else
		lstr_param.s_argumentos[7] = "N"
	end if
		
	if cbx_declaracion_entrada_entrega_intracom.checked then
		lstr_param.s_argumentos[8] = "S"
	else
		lstr_param.s_argumentos[8] = "N"
	end if
		
	OpenWithParm(w_lis_venfacturas,lstr_param)
//   dw_preliminar.Print(FALSE)
//   dw_preliminar.Reset()
NEXT


f_activar_campo(em_fecha1)

destroy dw
end event

type st_13 from statictext within w_lis_venfacturas_fechas
integer x = 2629
integer y = 320
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera:"
boolean focusrectangle = false
end type

type uo_1 from u_selec_impresoras within w_lis_venfacturas_fechas
integer x = 46
integer y = 288
integer width = 1403
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_6 from statictext within w_lis_venfacturas_fechas
integer x = 2158
integer y = 324
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_22 from statictext within w_lis_venfacturas_fechas
integer x = 18
integer y = 148
integer width = 174
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_serie from u_em_campo within w_lis_venfacturas_fechas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 201
integer y = 144
integer width = 151
integer taborder = 10
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF


end event

type st_nombre_serie from statictext within w_lis_venfacturas_fechas
integer x = 357
integer y = 140
integer width = 1070
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venfacturas_fechas
integer x = 2898
integer y = 312
integer width = 247
integer height = 228
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Sí","No"}
end type

type gb_4 from groupbox within w_lis_venfacturas_fechas
integer x = 1458
integer y = 252
integer width = 2295
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_4 from statictext within w_lis_venfacturas_fechas
integer x = 2999
integer y = 156
integer width = 105
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fra:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fra1 from u_em_campo within w_lis_venfacturas_fechas
integer x = 3122
integer y = 144
integer width = 242
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "####,##0"
string displaydata = ""
end type

type st_5 from statictext within w_lis_venfacturas_fechas
integer x = 2135
integer y = 120
integer width = 69
integer height = 84
integer textsize = -18
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = " -"
boolean focusrectangle = false
end type

type em_fra2 from u_em_campo within w_lis_venfacturas_fechas
integer x = 3451
integer y = 144
integer width = 247
integer taborder = 50
string text = "    "
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
string displaydata = ""
end type

type matricial from checkbox within w_lis_venfacturas_fechas
integer x = 2542
integer y = 160
integer width = 384
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Matricial"
boolean lefttext = true
end type

type st_3 from statictext within w_lis_venfacturas_fechas
integer x = 3365
integer y = 132
integer width = 69
integer height = 88
integer textsize = -18
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = " -"
boolean focusrectangle = false
end type

type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas_fechas
integer x = 1477
integer y = 312
integer width = 727
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Declaracion Entrega Intr."
boolean checked = true
end type

type gb_3 from groupbox within w_lis_venfacturas_fechas
integer x = 5
integer y = 88
integer width = 3739
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

