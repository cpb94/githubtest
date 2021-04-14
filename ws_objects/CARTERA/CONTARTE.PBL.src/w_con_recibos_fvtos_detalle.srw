$PBExportHeader$w_con_recibos_fvtos_detalle.srw
$PBExportComments$€
forward
global type w_con_recibos_fvtos_detalle from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_fvtos_detalle
end type
type cb_1 from u_boton within w_con_recibos_fvtos_detalle
end type
type uo_tipo from u_marca_lista within w_con_recibos_fvtos_detalle
end type
type dw_proceso from datawindow within w_con_recibos_fvtos_detalle
end type
type cb_consulta from u_boton within w_con_recibos_fvtos_detalle
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_fvtos_detalle
end type
type st_8 from statictext within w_con_recibos_fvtos_detalle
end type
type em_fechadesde from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_9 from statictext within w_con_recibos_fvtos_detalle
end type
type gb_1 from groupbox within w_con_recibos_fvtos_detalle
end type
type em_fechahasta from u_em_campo within w_con_recibos_fvtos_detalle
end type
type cb_2 from u_boton within w_con_recibos_fvtos_detalle
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_fvtos_detalle
end type
type dw_proceso2 from datawindow within w_con_recibos_fvtos_detalle
end type
type em_banco from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_1 from statictext within w_con_recibos_fvtos_detalle
end type
type em_cliente from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_nombre_cliente from statictext within w_con_recibos_fvtos_detalle
end type
type st_3 from statictext within w_con_recibos_fvtos_detalle
end type
type st_nombre_banco from statictext within w_con_recibos_fvtos_detalle
end type
type st_2 from statictext within w_con_recibos_fvtos_detalle
end type
type em_comercial from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_agente from statictext within w_con_recibos_fvtos_detalle
end type
type uo_grupo from u_em_campo_2 within w_con_recibos_fvtos_detalle
end type
type ddlb_efectos_anticipados from dropdownlistbox within w_con_recibos_fvtos_detalle
end type
type gb_9 from groupbox within w_con_recibos_fvtos_detalle
end type
type gb_2 from groupbox within w_con_recibos_fvtos_detalle
end type
type dw_listado from datawindow within w_con_recibos_fvtos_detalle
end type
type dw_1 from datawindow within w_con_recibos_fvtos_detalle
end type
type st_4 from statictext within w_con_recibos_fvtos_detalle
end type
type em_pais from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_nombre_pais from statictext within w_con_recibos_fvtos_detalle
end type
type st_5 from statictext within w_con_recibos_fvtos_detalle
end type
type sle_importe from singlelineedit within w_con_recibos_fvtos_detalle
end type
type cbx_wow_usa from checkbox within w_con_recibos_fvtos_detalle
end type
type ddlb_operador from dropdownlistbox within w_con_recibos_fvtos_detalle
end type
type st_6 from statictext within w_con_recibos_fvtos_detalle
end type
type em_fecha_fra_desde from u_em_campo within w_con_recibos_fvtos_detalle
end type
type st_7 from statictext within w_con_recibos_fvtos_detalle
end type
type em_fecha_fra_hasta from u_em_campo within w_con_recibos_fvtos_detalle
end type
type gb_3 from groupbox within w_con_recibos_fvtos_detalle
end type
end forward

global type w_con_recibos_fvtos_detalle from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4722
integer height = 3320
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_1 gb_1
em_fechahasta em_fechahasta
cb_2 cb_2
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
em_banco em_banco
st_1 st_1
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
st_3 st_3
st_nombre_banco st_nombre_banco
st_2 st_2
em_comercial em_comercial
st_agente st_agente
uo_grupo uo_grupo
ddlb_efectos_anticipados ddlb_efectos_anticipados
gb_9 gb_9
gb_2 gb_2
dw_listado dw_listado
dw_1 dw_1
st_4 st_4
em_pais em_pais
st_nombre_pais st_nombre_pais
st_5 st_5
sle_importe sle_importe
cbx_wow_usa cbx_wow_usa
ddlb_operador ddlb_operador
st_6 st_6
em_fecha_fra_desde em_fecha_fra_desde
st_7 st_7
em_fecha_fra_hasta em_fecha_fra_hasta
gb_3 gb_3
end type
global w_con_recibos_fvtos_detalle w_con_recibos_fvtos_detalle

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,numero2,registros2,x2
String filtro,filtro1,filtro2,filtro21,fil,nexo

filtro = ""
filtro2 = ""
numero = uo_tipo.dw_marca.RowCount()
numero2 = uo_tipo2.dw_marca.RowCount()
IF numero =0 and numero2 =0 Then return ""


	FOR x1 = 1 To numero
   		IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
     			
      		IF Trim(filtro) = "" Then
         		filtro1 = " situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      		Else
         		filtro1 = " Or situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
     			End If
      		filtro = filtro  + filtro1
				filtro  = "(" + filtro + ")"
   		END IF
	NEXT



	FOR x2 = 1 To numero2
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	
      	IF Trim(filtro2) = "" Then
         	filtro21 = " tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro21 = " Or tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro2 = filtro2  + filtro21
			filtro2  = "(" + filtro2 + ")"
  		END IF
	NEXT


if trim(filtro)="" then
	if trim(filtro2)="" then
		nexo=""
	else
		nexo=""
	end if
else
	if trim(filtro2)="" then
		nexo=""
	else 
		nexo=" and "
	end if
end if
 
fil= filtro2 + nexo + filtro

return fil
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
string vengrupo, efectos_anticipados
dec importe
Datetime fecha1,fecha2
Datetime ffra_desde, ffra_hasta

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()


fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))
ffra_desde = Datetime(Date(String(em_fecha_fra_desde.Text)))
ffra_hasta = Datetime(Date(String(em_fecha_fra_hasta.Text)))

string f="",fi=""

if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if


f=f_filtro()
IF f="" then
	f=fi
else
	f=f_filtro() + "and" + fi
end if

if em_cliente.text <> '' and not isnull(em_cliente.text) then
	f = f + " and cliente = '"+em_cliente.text+"' "
end if

if sle_importe.text <> '' and not isnull(sle_importe.text) then
	f = f + " and importe "+ddlb_operador.text+sle_importe.text
end if

if cbx_wow_usa.checked then
	f = f + " and cliente <> '216'"
end if
if em_pais.text <> '' and not isnull(em_pais.text) then
	f = f + " and pais = '"+em_pais.text+"' "
end if


if em_banco.text <> '' and not isnull(em_banco.text) then
	f = f + " and banco = '"+em_banco.text+"' "
end if

if em_comercial.text <> '' and not isnull(em_comercial.text) then
	f = f + " and agente1 = '"+em_comercial.text+"' "
end if

if uo_grupo.em_codigo.text <> '' and not isnull(uo_grupo.em_codigo.text) then
	vengrupo = uo_grupo.em_codigo.text
else 
	vengrupo = '%'
end if


if ddlb_efectos_anticipados.text = 'Todos' then
	efectos_anticipados = '%'
else
	efectos_anticipados = ddlb_efectos_anticipados.text
end if 


dw_data.SetFilter(f)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa, fecha1, fecha2, vengrupo, efectos_anticipados, ffra_desde, ffra_hasta)
registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE EFECTOS POR FECHA DE VENCIMIENTO"

//em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechadesde.text = '01-01-01'
em_fechahasta.text = String(RelativeDate (Today(), 730) )
//em_fecha_fra_desde.text = String(MDY(01,01,Year(Today())))
em_fecha_fra_desde.text =  '01-01-01'
em_fecha_fra_hasta.text = String(Today())
ddlb_operador.text = "<="
dw_1.Setfocus()

Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
registros=dw_proceso.retrieve(codigo_empresa)

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"codigo")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo.st_titulo1.text="Situación"
uo_tipo.st_titulo2.text="Descripcion"


Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"tipodoc")
  var_texto2   = dw_proceso2.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"
ddlb_efectos_anticipados.text = "Todos"

f_activar_campo(em_fechadesde)


end event

on w_con_recibos_fvtos_detalle.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.cb_2=create cb_2
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.em_banco=create em_banco
this.st_1=create st_1
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.st_3=create st_3
this.st_nombre_banco=create st_nombre_banco
this.st_2=create st_2
this.em_comercial=create em_comercial
this.st_agente=create st_agente
this.uo_grupo=create uo_grupo
this.ddlb_efectos_anticipados=create ddlb_efectos_anticipados
this.gb_9=create gb_9
this.gb_2=create gb_2
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.st_4=create st_4
this.em_pais=create em_pais
this.st_nombre_pais=create st_nombre_pais
this.st_5=create st_5
this.sle_importe=create sle_importe
this.cbx_wow_usa=create cbx_wow_usa
this.ddlb_operador=create ddlb_operador
this.st_6=create st_6
this.em_fecha_fra_desde=create em_fecha_fra_desde
this.st_7=create st_7
this.em_fecha_fra_hasta=create em_fecha_fra_hasta
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.em_fechahasta
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.uo_tipo2
this.Control[iCurrent+14]=this.dw_proceso2
this.Control[iCurrent+15]=this.em_banco
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.em_cliente
this.Control[iCurrent+18]=this.st_nombre_cliente
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_nombre_banco
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.em_comercial
this.Control[iCurrent+23]=this.st_agente
this.Control[iCurrent+24]=this.uo_grupo
this.Control[iCurrent+25]=this.ddlb_efectos_anticipados
this.Control[iCurrent+26]=this.gb_9
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.dw_listado
this.Control[iCurrent+29]=this.dw_1
this.Control[iCurrent+30]=this.st_4
this.Control[iCurrent+31]=this.em_pais
this.Control[iCurrent+32]=this.st_nombre_pais
this.Control[iCurrent+33]=this.st_5
this.Control[iCurrent+34]=this.sle_importe
this.Control[iCurrent+35]=this.cbx_wow_usa
this.Control[iCurrent+36]=this.ddlb_operador
this.Control[iCurrent+37]=this.st_6
this.Control[iCurrent+38]=this.em_fecha_fra_desde
this.Control[iCurrent+39]=this.st_7
this.Control[iCurrent+40]=this.em_fecha_fra_hasta
this.Control[iCurrent+41]=this.gb_3
end on

on w_con_recibos_fvtos_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.cb_2)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.st_3)
destroy(this.st_nombre_banco)
destroy(this.st_2)
destroy(this.em_comercial)
destroy(this.st_agente)
destroy(this.uo_grupo)
destroy(this.ddlb_efectos_anticipados)
destroy(this.gb_9)
destroy(this.gb_2)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.em_pais)
destroy(this.st_nombre_pais)
destroy(this.st_5)
destroy(this.sle_importe)
destroy(this.cbx_wow_usa)
destroy(this.ddlb_operador)
destroy(this.st_6)
destroy(this.em_fecha_fra_desde)
destroy(this.st_7)
destroy(this.em_fecha_fra_hasta)
destroy(this.gb_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_fvtos_detalle
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_fvtos_detalle
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_fvtos_detalle
integer y = 20
integer width = 1463
end type

type pb_2 from upb_salir within w_con_recibos_fvtos_detalle
integer x = 4544
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type cb_1 from u_boton within w_con_recibos_fvtos_detalle
integer x = 4197
integer y = 120
integer width = 293
integer height = 96
integer taborder = 0
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 2825
integer y = 448
integer width = 1349
integer height = 656
integer taborder = 90
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 242
integer y = 8
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_con_recibos_fvtos_detalle
integer x = 4197
integer y = 212
integer width = 293
integer height = 96
integer taborder = 0
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)


end event

type pb_imprimir_preli from picturebutton within w_con_recibos_fvtos_detalle
integer x = 4544
integer y = 160
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
Parent.TriggerEvent("ue_listar")

end event

type st_8 from statictext within w_con_recibos_fvtos_detalle
integer x = 457
integer y = 204
integer width = 206
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 224
integer y = 196
integer width = 233
integer height = 80
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_recibos_fvtos_detalle
integer x = 32
integer y = 204
integer width = 192
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_recibos_fvtos_detalle
integer x = 27
integer y = 132
integer width = 878
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Vto"
end type

type em_fechahasta from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 654
integer y = 196
integer width = 233
integer height = 80
integer taborder = 70
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_2 from u_boton within w_con_recibos_fvtos_detalle
event clicked pbm_bnclicked
integer x = 4197
integer y = 28
integer width = 293
integer height = 96
integer taborder = 0
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type uo_tipo2 from u_marca_lista within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 2075
integer y = 448
integer width = 1349
integer height = 656
integer taborder = 80
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 1147
integer y = 8
integer width = 325
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type em_banco from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 2098
integer y = 128
integer width = 187
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE BANCO"
ue_datawindow ="dw_ayuda_carbancos"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type st_1 from statictext within w_con_recibos_fvtos_detalle
integer x = 1856
integer y = 132
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "Banco:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 2098
integer y = 216
integer width = 187
integer taborder = 40
boolean bringtotop = true
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE CLIENTES"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,"C",em_cliente.text)
end event

type st_nombre_cliente from statictext within w_con_recibos_fvtos_detalle
integer x = 2295
integer y = 220
integer width = 1138
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_recibos_fvtos_detalle
integer x = 1856
integer y = 220
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_con_recibos_fvtos_detalle
integer x = 2295
integer y = 132
integer width = 1138
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_recibos_fvtos_detalle
integer x = 1856
integer y = 44
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "Agente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_comercial from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 2098
integer y = 40
integer width = 187
integer taborder = 50
boolean bringtotop = true
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION AGENTE"
ue_datawindow ="dw_ayuda_venagentes"
ue_filtro =""

valor_empresa = TRUE
end event

event modificado;call super::modificado;String codigo, descripcion 

codigo = this.text
SELECT nombre INTO :descripcion FROM venagentes WHERE agente = :codigo; 
st_agente.text = descripcion
end event

type st_agente from statictext within w_con_recibos_fvtos_detalle
integer x = 2295
integer y = 44
integer width = 1138
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within w_con_recibos_fvtos_detalle
event destroy ( )
integer x = 3566
integer y = 60
integer width = 544
integer height = 88
integer taborder = 100
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from vengrupos
where empresa = :codigo_empresa
and codigo = :uo_grupo.em_codigo.text;

uo_grupo.em_campo.text= descripcion
IF Trim(uo_grupo.em_campo.text)="" THEN 
	IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
	uo_grupo.em_campo.text=""
	uo_grupo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Grupos de Clientes"
ue_datawindow = "dw_ayuda_vengrupos"
ue_filtro     = ""

end event

type ddlb_efectos_anticipados from dropdownlistbox within w_con_recibos_fvtos_detalle
integer x = 3566
integer y = 224
integer width = 530
integer height = 352
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"S","N","Todos"}
borderstyle borderstyle = stylelowered!
end type

type gb_9 from groupbox within w_con_recibos_fvtos_detalle
integer x = 3525
integer y = 8
integer width = 608
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Grupo Cliente"
end type

type gb_2 from groupbox within w_con_recibos_fvtos_detalle
integer x = 3525
integer y = 168
integer width = 608
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Efectos Anticipados"
end type

type dw_listado from datawindow within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 3589
integer y = 1616
integer width = 402
integer height = 68
string dataobject = "report_carefectos_fvtos_detalle"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_recibos_fvtos_detalle
boolean visible = false
integer x = 18
integer y = 444
integer width = 4667
integer height = 2696
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_con_carefectos_fvtos_detalle"
boolean vscrollbar = true
boolean livescroll = true
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

type st_4 from statictext within w_con_recibos_fvtos_detalle
integer x = 1856
integer y = 308
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "País:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pais from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 2098
integer y = 304
integer width = 187
integer taborder = 50
boolean bringtotop = true
long backcolor = 16777215
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE PAÍSES"
ue_datawindow ="dw_ayuda_paises"
ue_filtro =""

valor_empresa = FALSE
end event

event modificado;call super::modificado;st_nombre_pais.text = f_nombre_pais(em_pais.text)
end event

type st_nombre_pais from statictext within w_con_recibos_fvtos_detalle
integer x = 2295
integer y = 308
integer width = 1138
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_recibos_fvtos_detalle
integer x = 869
integer y = 332
integer width = 315
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "Importe"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_importe from singlelineedit within w_con_recibos_fvtos_detalle
integer x = 1467
integer y = 324
integer width = 334
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_wow_usa from checkbox within w_con_recibos_fvtos_detalle
integer x = 3534
integer y = 352
integer width = 640
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 553648127
string text = "Cliente <> Wow Usa"
boolean checked = true
boolean lefttext = true
end type

type ddlb_operador from dropdownlistbox within w_con_recibos_fvtos_detalle
integer x = 1221
integer y = 324
integer width = 233
integer height = 324
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
string item[] = {"<=",">"}
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_con_recibos_fvtos_detalle
integer x = 1358
integer y = 208
integer width = 215
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha_fra_desde from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 1134
integer y = 200
integer width = 233
integer height = 80
integer taborder = 70
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_recibos_fvtos_detalle
integer x = 928
integer y = 208
integer width = 210
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha_fra_hasta from u_em_campo within w_con_recibos_fvtos_detalle
integer x = 1554
integer y = 200
integer width = 242
integer height = 80
integer taborder = 70
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_3 from groupbox within w_con_recibos_fvtos_detalle
integer x = 923
integer y = 136
integer width = 896
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Factura"
end type

