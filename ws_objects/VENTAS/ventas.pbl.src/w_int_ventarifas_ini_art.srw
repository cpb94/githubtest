$PBExportHeader$w_int_ventarifas_ini_art.srw
forward
global type w_int_ventarifas_ini_art from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_ventarifas_ini_art
end type
type st_2 from statictext within w_int_ventarifas_ini_art
end type
type em_tarifa from u_em_campo within w_int_ventarifas_ini_art
end type
type st_nombre_tarifa from statictext within w_int_ventarifas_ini_art
end type
type dw_fechas from datawindow within w_int_ventarifas_ini_art
end type
type dw_proceso from datawindow within w_int_ventarifas_ini_art
end type
type cb_continuar from u_boton within w_int_ventarifas_ini_art
end type
type dw_proceso2 from datawindow within w_int_ventarifas_ini_art
end type
type cb_calidades from u_boton within w_int_ventarifas_ini_art
end type
type uo_tipo from u_marca_lista within w_int_ventarifas_ini_art
end type
type dw_proceso_cal from datawindow within w_int_ventarifas_ini_art
end type
type gb_2 from groupbox within w_int_ventarifas_ini_art
end type
type sle_moneda from statictext within w_int_ventarifas_ini_art
end type
type st_3 from statictext within w_int_ventarifas_ini_art
end type
type em_cambio from u_em_campo within w_int_ventarifas_ini_art
end type
type ddlb_pantilla from dropdownlistbox within w_int_ventarifas_ini_art
end type
type st_4 from statictext within w_int_ventarifas_ini_art
end type
type dw_proceso3 from datawindow within w_int_ventarifas_ini_art
end type
type dw_detalle from u_datawindow_consultas within w_int_ventarifas_ini_art
end type
type cb_salir from u_boton within w_int_ventarifas_ini_art
end type
type cb_procesar from u_boton within w_int_ventarifas_ini_art
end type
type gb_1 from groupbox within w_int_ventarifas_ini_art
end type
type st_1 from statictext within w_int_ventarifas_ini_art
end type
type st_5 from statictext within w_int_ventarifas_ini_art
end type
type em_inicial from u_em_campo within w_int_ventarifas_ini_art
end type
end forward

global type w_int_ventarifas_ini_art from w_int_con_empresa
integer width = 2930
integer height = 1712
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
dw_proceso dw_proceso
cb_continuar cb_continuar
dw_proceso2 dw_proceso2
cb_calidades cb_calidades
uo_tipo uo_tipo
dw_proceso_cal dw_proceso_cal
gb_2 gb_2
sle_moneda sle_moneda
st_3 st_3
em_cambio em_cambio
ddlb_pantilla ddlb_pantilla
st_4 st_4
dw_proceso3 dw_proceso3
dw_detalle dw_detalle
cb_salir cb_salir
cb_procesar cb_procesar
gb_1 gb_1
st_1 st_1
st_5 st_5
em_inicial em_inicial
end type
global w_int_ventarifas_ini_art w_int_ventarifas_ini_art

type variables
string filtro,bloqueado
Integer bien
end variables

forward prototypes
public function boolean f_grabar (string cod_familia, string cod_formato, string cod_calidad, decimal precio)
public function string f_filter ()
end prototypes

public function boolean f_grabar (string cod_familia, string cod_formato, string cod_calidad, decimal precio);String   tar_empresa,tar_tarifa,tar_formato,tar_familia,&
         tar_articulo,tar_calidad,tar_montajeartcal,&
         tar_modelo,tar_activo,tar_listar,tar_usuario,&
         tar_descripcion,tar_excepcion,tar_tipo_linea,var_inicial
Datetime tar_fecha,tar_falta,var_fecha
Decimal  tar_precio
Integer x1,registros
var_fecha = dw_fechas.GetItemDatetime(dw_fechas.GetRow(),"fecha")
var_inicial = Trim(em_inicial.text) + "%"

  INSERT INTO ventarfamfor  
         ( empresa,tarifa,fecha,familia,formato,calidad,precio )  
  VALUES ( :codigo_empresa,:em_tarifa.text,:var_fecha,:cod_familia,   
           :cod_formato,:cod_calidad,:precio )  ;

registros = dw_proceso2.Retrieve(codigo_empresa,cod_familia,cod_formato,DateTime(Today()),var_inicial)
If registros <>0 Then
  FOR x1 = 1 To registros
    tar_empresa  =   codigo_empresa
    tar_tarifa   =   em_tarifa.text
    tar_fecha    =   var_fecha
    tar_articulo =   dw_proceso2.GetItemString(x1,"codigo")
    tar_calidad  =   cod_calidad
    tar_precio   =   precio
    tar_montajeartcal = f_componer_artcal(tar_articulo,tar_calidad)
    tar_familia= cod_familia
    tar_formato = cod_formato
    tar_modelo  =dw_proceso2.GetItemString(x1,"modelo")
    tar_activo ="S"
    tar_listar ="S"
    tar_usuario = nombre_usuario
    tar_descripcion = f_nombre_articulo(codigo_empresa,tar_articulo)
    tar_excepcion="N"
	 IF f_unidad_articulo(codigo_empresa,tar_articulo)  = "0" Then
	   tar_tipo_linea = "2"
	 ELSE 
	   tar_tipo_linea = "1"
    END IF
	 
  INSERT INTO venlintarifas  
         ( empresa,tarifa,fecha,articulo,calidad,precio,falta,   
           montajeartcal,familia,formato,modelo,activo,listar,   
           usuario,descripcion,excepcion,tipo_linea )  
  VALUES ( :tar_empresa,:tar_tarifa,:tar_fecha,:tar_articulo,   
           :tar_calidad,:tar_precio,:tar_falta,:tar_montajeartcal,   
           :tar_familia,:tar_formato,:tar_modelo,:tar_activo,:tar_listar,   
           :tar_usuario,:tar_descripcion,:tar_excepcion,:tar_tipo_linea);
  IF SQLCA.SqlCode <> 0 Then bien=1

  NEXT
END IF

RETURN TRUE
end function

public function string f_filter ();Integer numero,registros,x1,y1
String filtro1,filtro2
y1=0
filtro2 = " "
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro2) = "" Then
         filtro1 = " calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro2 = filtro2  + filtro1
   END IF
NEXT
Return filtro2
end function

on close;call w_int_con_empresa::close;If bloqueado="S" Then 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
End IF
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Generacion de tarifas"
This.title=istr_parametros.s_titulo_ventana

ddlb_pantilla.text = "Si"
dw_detalle.SetTransObject(SQLCA)
dw_fechas.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_proceso3.SetTransObject(SQLCA)
dw_fechas.SetRowFocusIndicator(Hand!)
bloqueado="N"

Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso_cal.SetTransObject(SQLCA)
registros=dw_proceso_cal.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso_cal.GetItemString(x1,"codigo")
  var_texto   = dw_proceso_cal.GetItemString(x1,"abreviado")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo.st_titulo1.text="Calidad"
uo_tipo.st_titulo2.text="Resumido"


end event

on ue_listar;//dw_report  = dw_listado
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

on w_int_ventarifas_ini_art.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.dw_proceso=create dw_proceso
this.cb_continuar=create cb_continuar
this.dw_proceso2=create dw_proceso2
this.cb_calidades=create cb_calidades
this.uo_tipo=create uo_tipo
this.dw_proceso_cal=create dw_proceso_cal
this.gb_2=create gb_2
this.sle_moneda=create sle_moneda
this.st_3=create st_3
this.em_cambio=create em_cambio
this.ddlb_pantilla=create ddlb_pantilla
this.st_4=create st_4
this.dw_proceso3=create dw_proceso3
this.dw_detalle=create dw_detalle
this.cb_salir=create cb_salir
this.cb_procesar=create cb_procesar
this.gb_1=create gb_1
this.st_1=create st_1
this.st_5=create st_5
this.em_inicial=create em_inicial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.st_nombre_tarifa
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.cb_continuar
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.cb_calidades
this.Control[iCurrent+10]=this.uo_tipo
this.Control[iCurrent+11]=this.dw_proceso_cal
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.sle_moneda
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.em_cambio
this.Control[iCurrent+16]=this.ddlb_pantilla
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.dw_proceso3
this.Control[iCurrent+19]=this.dw_detalle
this.Control[iCurrent+20]=this.cb_salir
this.Control[iCurrent+21]=this.cb_procesar
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.st_1
this.Control[iCurrent+24]=this.st_5
this.Control[iCurrent+25]=this.em_inicial
end on

on w_int_ventarifas_ini_art.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.dw_proceso)
destroy(this.cb_continuar)
destroy(this.dw_proceso2)
destroy(this.cb_calidades)
destroy(this.uo_tipo)
destroy(this.dw_proceso_cal)
destroy(this.gb_2)
destroy(this.sle_moneda)
destroy(this.st_3)
destroy(this.em_cambio)
destroy(this.ddlb_pantilla)
destroy(this.st_4)
destroy(this.dw_proceso3)
destroy(this.dw_detalle)
destroy(this.cb_salir)
destroy(this.cb_procesar)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.em_inicial)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_ventarifas_ini_art
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_ventarifas_ini_art
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_ventarifas_ini_art
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_ventarifas_ini_art
integer x = 2693
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_int_ventarifas_ini_art
integer y = 132
integer width = 206
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_int_ventarifas_ini_art
integer x = 215
integer y = 128
integer width = 261
integer taborder = 20
end type

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF
String v_moneda
//***
v_moneda=f_moneda_ventarifas(codigo_empresa,em_tarifa.text)
if v_moneda="1" then
	f_mascara_columna(dw_detalle,"precio","###,###,###,###.00")
else
	f_mascara_columna(dw_detalle,"precio",f_mascara_precios_moneda(v_moneda))
end if	

dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   
sle_moneda.text = f_nombre_moneda_abr(f_moneda_ventarifas(codigo_empresa,em_tarifa.text))
em_cambio.text = String(f_cambio_moneda(f_moneda_ventarifas(codigo_empresa,em_tarifa.text)))


 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type st_nombre_tarifa from statictext within w_int_ventarifas_ini_art
integer x = 480
integer y = 128
integer width = 1042
integer height = 84
boolean bringtotop = true
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

type dw_fechas from datawindow within w_int_ventarifas_ini_art
integer x = 1806
integer y = 128
integer width = 640
integer height = 248
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!

end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type dw_proceso from datawindow within w_int_ventarifas_ini_art
boolean visible = false
integer x = 613
integer width = 1111
integer height = 112
boolean bringtotop = true
string dataobject = "dw_proceso_calformatos_inic"
boolean livescroll = true
end type

type cb_continuar from u_boton within w_int_ventarifas_ini_art
integer x = 2459
integer y = 252
integer width = 352
integer height = 88
integer taborder = 100
string text = "&Continuar"
end type

event clicked;IF Trim(st_nombre_tarifa.text) = "" Then 
  MessageBox("Introduzca un tarifa","No se ha introducido ninguna tarifa",Exclamation!, OK!,1)
  f_activar_campo(em_tarifa)
  Return
END IF
IF dw_fechas.GetRow() = 0 Then
   MessageBox("Marcar un fecha","No se ha seleccionado una fecha de tarifa",Exclamation!, OK!,1)
  dw_fechas.Setfocus()
  return
END IF

Datetime fecha_tarifa
fecha_tarifa = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
Integer  numero,contando
contando = 0

Select count(*) Into :numero From venlintarifas
Where  venlintarifas.empresa = :codigo_empresa
And    venlintarifas.tarifa  = :em_tarifa.text
And    venlintarifas.fecha   = :fecha_tarifa;
IF ISNull(numero) Then numero=0
IF numero <>0 THEN
 MessageBox("Tarifa ya generada","Esta tarifa ya existe",Exclamation!, OK!,1)
f_activar_campo(em_tarifa)
Return
END IF
uo_tipo.visible = FALSE


Integer registros,x1,registros2,x2
dw_proceso.SetFilter("")
dw_proceso.SetFilter(f_filter())
dw_proceso.Filter()
dw_proceso.GroupCalc()

registros2  = dw_proceso3.retrieve(codigo_empresa)

IF registros2 = 0 Then  return

 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 
 longitud      =  len(trim(em_tarifa.text))
 criterio[2]   =  trim(em_tarifa.text)+space(20-longitud)
 datetime fecha
 fecha = dw_fechas.GetItemDatetime(dw_fechas.GetRow(),"fecha")
 longitud      =  len(trim(String(fecha)))
 criterio[3]   =  trim(String(fecha))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]
 tabla         =  "venmapatarifas"

 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion

  em_tarifa.enabled      = FALSE
  dw_fechas.enabled      = FALSE
  cb_continuar.enabled   = FALSE
  cb_calidades.enabled   = FALSE
  em_cambio.enabled      = FALSE
  ddlb_pantilla.enabled  = FALSE
  
  bloqueado="S"
  String   var_formato,var_calidad,var_familia,var_iniciales
  Dec{4}   var_precioventa
  Dec{0} num
  var_iniciales = Trim(em_inicial.text) + '%'
  
  dw_detalle.visible = False

  FOR x2 = 1 To registros2
     var_formato  =     dw_proceso3.GetItemString(x2,"formato")
     var_familia  =     dw_proceso3.GetItemString(x2,"familia")
     registros    =     dw_proceso.retrieve(codigo_empresa,var_formato)
  	  SELECT Count(*)
		 INTO :num
		 FROM articulos
		 WHERE articulos.formato = :var_formato
		 AND   articulos.familia = :var_familia
		 AND   articulos.descripcion like :var_iniciales;
		if num >0 then
		  FOR x1 = 1 To registros
			  var_calidad  =     dw_proceso.GetItemString(x1,"calidad")
			  IF ddlb_pantilla.text = "Si" Then
				 var_precioventa  =    (dw_proceso.GetItemNumber(x1,"precioventa")) / Dec(em_cambio.text)
			  ELSE 
				var_precioventa   =    0
			  END IF
			  contando = contando +1
			  dw_detalle.InsertRow(contando)
			  dw_detalle.SetItem(contando,"familia",f_nombre_familia(codigo_empresa,var_familia))
			  dw_detalle.SetItem(contando,"formato",f_nombre_formato(codigo_empresa,var_formato))
			  dw_detalle.SetItem(contando,"cod_familia",var_familia)
			  dw_detalle.SetItem(contando,"cod_formato",var_formato)
			  dw_detalle.SetItem(contando,"calidad",f_nombre_calidad_abr(codigo_empresa,var_calidad))
			  dw_detalle.SetItem(contando,"cod_calidad",var_calidad)
			  dw_detalle.SetItem(contando,"precio",var_precioventa)
			  dw_detalle.SetItem(contando,"revisado","N")
			  f_contador_procesos(x2,registros2)
		  NEXT
	end if
  NEXT
  f_contador_procesos(registros2,registros2)
  dw_detalle.SetSort("")
  dw_detalle.SetSort("familia,formato")
  dw_detalle.Sort()
  gb_1.visible         = TRUE
  dw_detalle.visible   = TRUE
  cb_procesar.visible  = TRUE
  cb_salir.visible     = TRUE
  
  dw_detalle.SetColumn("precio")
  dw_detalle.SetFocus()
  
ELSE
  f_activar_campo(em_tarifa)
  Return
END IF
end event

type dw_proceso2 from datawindow within w_int_ventarifas_ini_art
boolean visible = false
integer width = 608
integer height = 112
boolean bringtotop = true
string dataobject = "dw_proceso_articulos_familia_formato_ini"
boolean livescroll = true
end type

type cb_calidades from u_boton within w_int_ventarifas_ini_art
event clicked pbm_bnclicked
integer x = 2459
integer y = 164
integer width = 352
integer height = 88
integer taborder = 60
string text = "C&alidades"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo.dw_marca.SetFocus()
end event

type uo_tipo from u_marca_lista within w_int_ventarifas_ini_art
boolean visible = false
integer x = 9
integer y = 380
integer width = 1454
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso_cal from datawindow within w_int_ventarifas_ini_art
boolean visible = false
integer x = 197
integer y = 24
integer width = 494
integer height = 104
string dataobject = "dw_proceso_calidades"
boolean livescroll = true
end type

type gb_2 from groupbox within w_int_ventarifas_ini_art
integer x = 2450
integer y = 132
integer width = 370
integer height = 216
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type sle_moneda from statictext within w_int_ventarifas_ini_art
integer x = 1527
integer y = 128
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_ventarifas_ini_art
integer x = 750
integer y = 260
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cambio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cambio from u_em_campo within w_int_ventarifas_ini_art
integer x = 1019
integer y = 256
integer taborder = 80
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0.00"
end type

type ddlb_pantilla from dropdownlistbox within w_int_ventarifas_ini_art
integer x = 485
integer y = 252
integer width = 247
integer height = 252
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_int_ventarifas_ini_art
integer x = 9
integer y = 260
integer width = 475
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Precio plantilla:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_proceso3 from datawindow within w_int_ventarifas_ini_art
boolean visible = false
integer x = 1723
integer width = 818
integer height = 112
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_familias_formatos_articulos_inic"
boolean livescroll = true
end type

type dw_detalle from u_datawindow_consultas within w_int_ventarifas_ini_art
integer x = 18
integer y = 380
integer width = 2693
integer height = 980
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_int_ventarifas_inic"
end type

event key;call super::key;String var_valor,var
var_valor = "S" 
IF key = KeyF5! Then 
	var = This.GetItemString(This.GetRow(),"revisado")
	IF var = "S" Then var_valor = "N"
	This.SetItem(This.GetRow(),"revisado",var_valor)
END IF
	
end event

type cb_salir from u_boton within w_int_ventarifas_ini_art
boolean visible = false
integer x = 2295
integer y = 1372
integer width = 347
integer height = 72
integer taborder = 0
string text = "&Salir"
end type

event clicked;call super::clicked; f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"

em_tarifa.enabled     = TRUE
dw_fechas.enabled     = TRUE
cb_continuar.enabled  = TRUE
cb_calidades.enabled  = TRUE
em_cambio.enabled      = TRUE
ddlb_pantilla.enabled  = TRUE

cb_procesar.visible   = FALSE
cb_salir.visible      = FALSE
gb_1.visible          = FALSE
dw_detalle.retrieve()
f_activar_campo(em_tarifa)
end event

type cb_procesar from u_boton within w_int_ventarifas_ini_art
boolean visible = false
integer x = 1952
integer y = 1372
integer width = 347
integer height = 72
integer taborder = 0
string text = "&Procesar"
end type

event clicked;call super::clicked;Integer registros,opcion,x1
dw_detalle.AcceptText()

registros = dw_detalle.Find("revisado='N'",1,dw_detalle.RowCount() )
If registros<> 0 Then
 opcion=  MessageBox("Existen lineas sin revisar","Desea Revisar el resto de lineas?",Question!,YesNo!,2)
 IF opcion=1 Then
    dw_detalle.ScrollToRow(registros)
    dw_detalle.SetFocus()
    Return
 END IF
END IF








// Proceso la insercion masiva de la tarifa

bien=0
registros  = dw_detalle.RowCount()
String var_familia,var_formato,var_calidad
Decimal var_precio
For x1 = 1 To registros
      var_formato   =  dw_detalle.GetItemString(x1,"cod_formato") 
      var_familia   =  dw_detalle.GetItemString(x1,"cod_familia") 
      var_calidad   =  dw_detalle.GetItemString(x1,"cod_calidad") 
      var_precio    =  dw_detalle.GetItemNumber(x1,"precio") 
      If IsNull(var_precio) Then var_precio = 0 
      If var_precio <> 0 Then
         f_grabar(var_familia,var_formato,var_calidad,var_precio)
      End If
		   f_contador_procesos(x1,registros)
Next

 CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE



cb_salir.TriggerEvent("clicked")

end event

type gb_1 from groupbox within w_int_ventarifas_ini_art
boolean visible = false
integer x = 1943
integer y = 1340
integer width = 713
integer height = 112
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_int_ventarifas_ini_art
integer x = 32
integer y = 1380
integer width = 1019
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(*) F5 marca/desmarca como revisado."
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_ventarifas_ini_art
integer x = 1317
integer y = 260
integer width = 197
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_inicial from u_em_campo within w_int_ventarifas_ini_art
integer x = 1531
integer y = 256
integer taborder = 90
boolean bringtotop = true
end type

