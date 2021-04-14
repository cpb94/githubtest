$PBExportHeader$w_con_efectos_anticipados_copia.srw
forward
global type w_con_efectos_anticipados_copia from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_efectos_anticipados_copia
end type
type cb_consulta from u_boton within w_con_efectos_anticipados_copia
end type
type pb_imprimir_preli from picturebutton within w_con_efectos_anticipados_copia
end type
type st_8 from statictext within w_con_efectos_anticipados_copia
end type
type em_fechadesde from u_em_campo within w_con_efectos_anticipados_copia
end type
type st_9 from statictext within w_con_efectos_anticipados_copia
end type
type gb_1 from groupbox within w_con_efectos_anticipados_copia
end type
type em_fechahasta from u_em_campo within w_con_efectos_anticipados_copia
end type
type dw_listado from datawindow within w_con_efectos_anticipados_copia
end type
type ddlb_1 from dropdownlistbox within w_con_efectos_anticipados_copia
end type
type cb_1 from u_boton within w_con_efectos_anticipados_copia
end type
type uo_tipo from u_marca_lista within w_con_efectos_anticipados_copia
end type
type dw_proceso from datawindow within w_con_efectos_anticipados_copia
end type
type dw_1 from datawindow within w_con_efectos_anticipados_copia
end type
type cb_2 from u_boton within w_con_efectos_anticipados_copia
end type
type uo_situacion from u_marca_lista within w_con_efectos_anticipados_copia
end type
end forward

global type w_con_efectos_anticipados_copia from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 1540
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_1 gb_1
em_fechahasta em_fechahasta
dw_listado dw_listado
ddlb_1 ddlb_1
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
dw_1 dw_1
cb_2 cb_2
uo_situacion uo_situacion
end type
global w_con_efectos_anticipados_copia w_con_efectos_anticipados_copia

type variables
String ante_articulo,retrasos
Integer orden = 1
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public function boolean f_anticipado (string par_empresa, decimal par_anyo, decimal par_efecto)
public function string f_filtro ()
end prototypes

public subroutine f_cargar (datawindow dw_data);datetime d1,d2
string sel
long i
dec el_anyo,el_orden

d1 = datetime(date(em_fechadesde.text))
d2 = datetime(date(em_fechahasta.text))

setpointer(hourglass!)



dw_data.setfilter("")
dw_data.filter()



dw_data.setfilter(f_filtro())
dw_data.filter()


dw_data.retrieve(codigo_empresa,d1,d2)



setpointer(arrow!)

end subroutine

public function boolean f_anticipado (string par_empresa, decimal par_anyo, decimal par_efecto);long cuantos

select count(*) into :cuantos from carfinanefe
where (carfinanefe.empresa = :par_empresa)	and
		(carfinanefe.ejercicio = :par_anyo)		and
		(carfinanefe.orden = :par_efecto);
		
if (sqlca.sqlcode = 100) or cuantos = 0  then return false		
if cuantos > 0 then return true

end function

public function string f_filtro ();String filtro,filtro3

filtro =""

if ddlb_1.text = "Anticipadas" then
	filtro = "(not isnull(carfinanefe_contador) ) "
else
	filtro = "isnull(carfinanefe_contador)"
END IF	

Integer numero,registros,x1,y1
String filtro2,filtro1
String tipos[]
y1=0
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro

tipos={""}

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
		tipos[x1] = uo_tipo.dw_marca.GetItemString(x1,"codigo")
      y1=y1+1
      IF Trim(filtro2) = "" Then
         filtro1 = " tipodoc = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or tipodoc = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro2 = filtro2  + filtro1
		filtro2  = " (" + filtro2 + ")"
   END IF
NEXT

if Trim(filtro) = "" then
	filtro = filtro + filtro2
else
	filtro = "( " + filtro + ") and " + filtro2
end if

numero = uo_situacion.dw_marca.RowCount()
IF numero =0 Then return filtro
filtro3 = ""

FOR x1 = 1 To numero
   IF uo_situacion.dw_marca.GetItemString(x1,"marca") = "S" THEN
		IF Trim(filtro3) = "" Then
         filtro3 =  " situacion = '" + uo_situacion.dw_marca.GetItemString(x1,"codigo") + "'"
      Else
         filtro3 = filtro3+" Or situacion = '" + uo_situacion.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      
   END IF
NEXT

if Trim(filtro) = "" then
	filtro = filtro + filtro3
else
	filtro = "( " + filtro + ") and " + filtro3
end if

return filtro
end function

event open;call super::open;
long x1,registros
String var_codigo, var_texto, marca
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS ANTICIPADOS"

dw_proceso.SetTransObject(SQLCA)
registros = dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"tipodoc")
  var_texto   = dw_proceso.GetItemString(x1,"texto")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo.st_titulo1.text="Tipo Doc."
uo_tipo.st_titulo2.text="Descripción"


em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_1.Setfocus()

f_activar_campo(em_fechadesde)

ddlb_1.text = "Anticipadas"

datastore xx
string sel
long indice,total

sel = "Select codigo,descripcion from carsituacion "+&
		"where empresa = '"+codigo_empresa+"'"
		
xx = f_cargar_cursor(sel)

total = xx.rowcount()

If total<>0 THEN
 	FOR indice = 1 To total
  		var_codigo  = xx.GetItemString(indice,"codigo")
  		var_texto   = xx.GetItemString(indice,"descripcion")
  		marca="S"
  		uo_situacion.dw_marca.InsertRow(indice)
  		uo_situacion.dw_marca.setitem(indice,"marca",marca)
  		uo_situacion.dw_marca.setitem(indice,"codigo",var_codigo)
  		uo_situacion.dw_marca.setitem(indice,"texto",var_texto)
	NEXT
end if

destroy(xx)
end event

on w_con_efectos_anticipados_copia.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.ddlb_1=create ddlb_1
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.dw_1=create dw_1
this.cb_2=create cb_2
this.uo_situacion=create uo_situacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.dw_listado
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.uo_tipo
this.Control[iCurrent+13]=this.dw_proceso
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.uo_situacion
end on

on w_con_efectos_anticipados_copia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.ddlb_1)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.uo_situacion)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_efectos_anticipados_copia
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_efectos_anticipados_copia
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_efectos_anticipados_copia
integer x = 5
integer y = 8
integer width = 2642
end type

type pb_2 from upb_salir within w_con_efectos_anticipados_copia
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_efectos_anticipados_copia
integer x = 2331
integer y = 184
integer width = 325
integer height = 88
integer taborder = 30
string text = "&Consulta"
end type

event clicked;f_cargar(dw_1)

uo_tipo.visible = false
uo_situacion.visible = false
dw_1.visible    = true

end event

type pb_imprimir_preli from picturebutton within w_con_efectos_anticipados_copia
integer x = 2679
integer y = 136
integer width = 183
integer height = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "\bmp\imp32.bmp"
end type

event clicked;if ddlb_1.text = "Anticipadas" then
	dw_listado.dataobject = "report_con_efectos_anticipados1"
else
	dw_listado.dataobject = "report_con_efectos_anticipados2"
end if

dw_listado.settransobject(sqlca)
choose case orden
	case 2
		dw_listado.SetSort("fvto A")
		dw_listado.Sort()
	case 1
		dw_listado.SetSort("number(factura) A, recibo A")
		dw_listado.Sort()
end choose

f_cargar(dw_listado)

uo_tipo.visible = false

f_imprimir_datawindow(dw_listado)
end event

type st_8 from statictext within w_con_efectos_anticipados_copia
integer x = 562
integer y = 200
integer width = 233
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

type em_fechadesde from u_em_campo within w_con_efectos_anticipados_copia
integer x = 279
integer y = 184
integer width = 302
integer height = 92
integer taborder = 50
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_efectos_anticipados_copia
integer x = 37
integer y = 200
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_efectos_anticipados_copia
integer x = 18
integer y = 120
integer width = 1129
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Factura"
end type

type em_fechahasta from u_em_campo within w_con_efectos_anticipados_copia
integer x = 791
integer y = 184
integer width = 302
integer height = 92
integer taborder = 60
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type dw_listado from datawindow within w_con_efectos_anticipados_copia
boolean visible = false
integer x = 2107
integer y = 136
integer width = 169
integer height = 144
string dataobject = "report_con_efectos_anticipados2"
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within w_con_efectos_anticipados_copia
integer x = 1161
integer y = 184
integer width = 517
integer height = 436
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Anticipadas","No Anticipadas"}
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_boton within w_con_efectos_anticipados_copia
integer x = 1682
integer y = 184
integer width = 370
integer height = 88
integer taborder = 70
string text = "Tipo Docum."
end type

event clicked;call super::clicked;if uo_tipo.visible then
	uo_tipo.visible = FALSE
	dw_1.visible = TRUE
else
	uo_tipo.visible = TRUE
	dw_1.visible = FALSE
end if
end event

type uo_tipo from u_marca_lista within w_con_efectos_anticipados_copia
boolean visible = false
integer x = 192
integer y = 292
integer taborder = 90
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_efectos_anticipados_copia
boolean visible = false
integer x = 320
integer y = 8
integer width = 494
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_proceso_cartipodoc"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_efectos_anticipados_copia
integer x = 23
integer y = 320
integer width = 2857
integer height = 1124
integer taborder = 110
string dataobject = "dw_con_efectos_anticipados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
//  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
//End If
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

event clicked;choose case f_objeto_datawindow(This) 
	case "venci" 
		dw_1.SetSort("fvto A")
		dw_1.Sort()
		orden = 2

	case "fra"
		dw_1.SetSort("Number(factura) A, recibo A")
		dw_1.Sort()
		orden = 1

end choose

end event

type cb_2 from u_boton within w_con_efectos_anticipados_copia
integer x = 2053
integer y = 184
integer width = 279
integer height = 88
integer taborder = 20
string text = "Situación"
end type

event clicked;if uo_situacion.visible then
	uo_situacion.visible = FALSE
	dw_1.visible = TRUE
else
	uo_situacion.visible = TRUE
	dw_1.visible = FALSE
end if
end event

type uo_situacion from u_marca_lista within w_con_efectos_anticipados_copia
boolean visible = false
integer x = 1550
integer y = 292
integer taborder = 100
end type

on uo_situacion.destroy
call u_marca_lista::destroy
end on

