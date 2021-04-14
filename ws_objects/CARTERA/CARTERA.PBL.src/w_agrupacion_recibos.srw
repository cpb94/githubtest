$PBExportHeader$w_agrupacion_recibos.srw
$PBExportComments$€
forward
global type w_agrupacion_recibos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_agrupacion_recibos
end type
type st_nombre_cliente from statictext within w_agrupacion_recibos
end type
type st_1 from statictext within w_agrupacion_recibos
end type
type em_cliente from u_em_campo within w_agrupacion_recibos
end type
type cb_2 from commandbutton within w_agrupacion_recibos
end type
type cb_1 from u_cancelar within w_agrupacion_recibos
end type
type uo_tipo2 from u_marca_lista within w_agrupacion_recibos
end type
type dw_cursor_agrupados from datawindow within w_agrupacion_recibos
end type
type cb_procesar from commandbutton within w_agrupacion_recibos
end type
type st_2 from statictext within w_agrupacion_recibos
end type
type st_3 from statictext within w_agrupacion_recibos
end type
type gb_1 from groupbox within w_agrupacion_recibos
end type
type dw_detalle from datawindow within w_agrupacion_recibos
end type
end forward

global type w_agrupacion_recibos from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 2930
integer height = 3208
pb_1 pb_1
st_nombre_cliente st_nombre_cliente
st_1 st_1
em_cliente em_cliente
cb_2 cb_2
cb_1 cb_1
uo_tipo2 uo_tipo2
dw_cursor_agrupados dw_cursor_agrupados
cb_procesar cb_procesar
st_2 st_2
st_3 st_3
gb_1 gb_1
dw_detalle dw_detalle
end type
global w_agrupacion_recibos w_agrupacion_recibos

type variables
string var_cuenta
string var_moneda=""
string var_accion
integer var_marcados=0
integer des_anyo,des_orden
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
string is_filtro=""
dec registros
dw_detalle.SetTransObject(sqlca)

dw_detalle.SetFilter("")
dw_detalle.Filter()

string fi=""
if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"

dw_detalle.SetFilter(fi)
dw_detalle.Filter()

dw_detalle.Retrieve(codigo_empresa,var_cuenta)

registros = dw_detalle.RowCount()

If registros = 0 Then Return

dw_detalle.visible=true
em_cliente.enabled=false
cb_2.enabled=false
dw_detalle.enabled=true
cb_1.enabled=true
cb_procesar.enabled=true
dw_detalle.setfocus()
var_moneda=""
cb_procesar.text="Procesar"
var_marcados=0
var_accion=""
st_2.visible=false
st_3.visible=false

end subroutine

event close;call super::close;dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Agrupación de Recibos"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle.visible=false
cb_1.enabled=false
cb_procesar.enabled=false

f_activar_campo(em_cliente)

end event

on w_agrupacion_recibos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_nombre_cliente=create st_nombre_cliente
this.st_1=create st_1
this.em_cliente=create em_cliente
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_tipo2=create uo_tipo2
this.dw_cursor_agrupados=create dw_cursor_agrupados
this.cb_procesar=create cb_procesar
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_nombre_cliente
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_cliente
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_tipo2
this.Control[iCurrent+8]=this.dw_cursor_agrupados
this.Control[iCurrent+9]=this.cb_procesar
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_detalle
end on

on w_agrupacion_recibos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_nombre_cliente)
destroy(this.st_1)
destroy(this.em_cliente)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_tipo2)
destroy(this.dw_cursor_agrupados)
destroy(this.cb_procesar)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.dw_detalle)
end on

event activate;call super::activate;w_agrupacion_recibos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_agrupacion_recibos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_agrupacion_recibos
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_cliente)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_agrupacion_recibos
integer width = 2880
integer height = 80
end type

type pb_1 from upb_salir within w_agrupacion_recibos
integer x = 2747
integer y = 116
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_nombre_cliente from statictext within w_agrupacion_recibos
integer x = 553
integer y = 128
integer width = 1202
integer height = 80
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

type st_1 from statictext within w_agrupacion_recibos
integer x = 32
integer y = 128
integer width = 242
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
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_agrupacion_recibos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 288
integer y = 124
integer width = 261
integer taborder = 20
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE CLIENTES"
		ue_datawindow = "dw_ayuda_clientes"
		ue_filtro     = ""
  		
        
end event

event modificado;call super::modificado;st_nombre_cliente.text = f_nombre_cliente(codigo_empresa,'C',em_cliente.text)	
if Trim(st_nombre_cliente.text)="" Then
      IF len( st_nombre_cliente.text) <> 0 Then f_activar_campo(em_cliente)
		em_cliente.text = ""
      return
End If

var_cuenta=f_cuenta_genter(codigo_empresa,'C',em_cliente.text)

end event

type cb_2 from commandbutton within w_agrupacion_recibos
integer x = 2345
integer y = 116
integer width = 352
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Continuar"
end type

event clicked;
if len(trim(string(em_cliente.text)))=0 then
	f_activar_campo(em_cliente)
	return
end if

f_control()
end event

type cb_1 from u_cancelar within w_agrupacion_recibos
integer x = 2450
integer y = 2920
integer width = 352
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Salir"
end type

event clicked;if cb_procesar.text="Continuar" then
	f_control()
	return
else
	var_marcados=0
	var_moneda=""
	cb_procesar.text="Procesar"
	var_accion=""
	st_2.visible=false
	st_3.visible=false
	em_cliente.enabled=true
	cb_2.enabled=true
	dw_detalle.Reset()
	dw_detalle.enabled=false
	dw_detalle.visible=false
	cb_1.enabled=false
	cb_procesar.enabled=false
	f_activar_campo(em_cliente)
	return
end if
end event

type uo_tipo2 from u_marca_lista within w_agrupacion_recibos
event destroy ( )
boolean visible = false
integer x = 1413
integer y = 364
integer width = 1454
integer height = 652
integer taborder = 50
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_cursor_agrupados from datawindow within w_agrupacion_recibos
boolean visible = false
integer x = 174
integer width = 325
integer height = 116
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_detalle_agrupados"
boolean livescroll = true
end type

type cb_procesar from commandbutton within w_agrupacion_recibos
event clicked pbm_bnclicked
integer x = 2080
integer y = 2920
integer width = 352
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Procesar"
end type

event clicked;integer bien=0
string  cadena

if var_accion="DESAGRUPAR" THEN
	
	//		PROCESO DE DESAGRUPAR
	
	if cb_procesar.text="Procesar" then
		string des_filtro
		des_filtro="((anyo = " + string(integer(des_anyo)) + ") and (orden =" + string(integer(des_orden)) +"))"
		dw_detalle.SetFilter(des_filtro)
		dw_detalle.Filter()
		st_3.visible=true
		cb_procesar.text="Continuar"
		return
	end if 

cb_procesar.text="Procesar"
st_3.visible=false

//selecciono detalle del registro agrupado

integer des_registros
dw_cursor_agrupados.SetTransObject(SQLCA)
dw_cursor_agrupados.retrieve(codigo_empresa,des_anyo,des_orden)
des_registros=dw_cursor_agrupados.rowcount()

//modifico registros agrupados
integer r
dec des_anyo_efecto,des_orden_efecto
for r=1 to des_registros
	des_anyo_efecto  =dw_cursor_agrupados.GetItemNumber(r,"anyo")
	des_orden_efecto =dw_cursor_agrupados.GetItemNumber(r,"orden")
	  UPDATE carefectos  
     SET situacion = "0",   
         efectoagrupa = null,   
         anyoagrupa = null
     WHERE  ( carefectos.empresa = :codigo_empresa) AND
			   ( carefectos.anyo = :des_anyo_efecto ) AND
            ( carefectos.orden = :des_orden_efecto );
	IF SQLCA.SQLCODE <> 0 Then bien = 1
next 

// borro el registro agrupado

  DELETE FROM carefectos  
   WHERE ( carefectos.empresa = :codigo_empresa ) AND  
         ( carefectos.anyo = :des_anyo ) AND  
         ( carefectos.orden = :des_orden )   ;
	IF SQLCA.SQLCODE <> 0 Then bien = 1
			
If bien <> 0  Then
	RollBack;
	f_mensaje("Error en proceso","El proceso no se actualiza(" +sqlca.sqlerrtext+")")
ELSE
	Commit;
END IF

f_desbloquear(tabla,seleccion,titulo)
COMMIT;

f_control()

//		FIN PROCESO DE DESAGRUPAR

ELSE
	
//		PROCESO DE AGRUPAR
	
	

if cb_procesar.text="Procesar" then
		dw_detalle.SetFilter("(libre = 'S')")
		dw_detalle.Filter()
		st_2.visible=true
		cb_procesar.text="Continuar"
		return
end if 

cb_procesar.text="Procesar"
st_2.visible=false
long registros
integer i,j=0,mayor=0,l[]
string marcado


dec{2} divisas,importe,div_max=0,total_div=0,total_imp
registros=dw_detalle.rowcount()
cadena = ""
for i=1 to registros
	marcado = dw_detalle.GetItemString(i,"libre") 
	if marcado="S" then 
		j=j+1
		divisas=dw_detalle.GetItemnumber(i,"divisas")
		importe=dw_detalle.GetItemnumber(i,"importe")
		cadena =cadena + dw_detalle.GetItemString(i,"factura") + " "
		total_div=total_div + divisas
		total_imp=total_imp + importe
		if divisas>div_max then 
			div_max=divisas
			mayor=i
		end if
		L[j]=i
	end if
next
if j=0 then 
	messagebox("No es posible procesar","No hay recibos marcados")
	f_control()
	return
end if
if j=1 then 
	messagebox("No es posible procesar","Sólo hay un recibo marcado")
	f_control()
	return
end if

Dec var_anyo,var_orden,orden_nuevo,anyo_efecto,orden_efecto
var_anyo  = dw_detalle.GetItemNumber(mayor,"anyo")
var_orden = dw_detalle.GetItemNumber(mayor,"orden")

//calculo del orden del efecto agrupado
integer longitudes
 titulo        =  Parent.title
 longitudes      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20 - longitudes)
 longitudes      =  len(trim(string(var_anyo)))
 criterio[2]   =  trim(string(var_anyo))+space(20 - longitudes)
 seleccion     =  criterio[1]+criterio[2]
 tabla         =  "carparam"
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion

orden_nuevo=f_orden_carparam(codigo_empresa,var_anyo)

for i=1 to j
	anyo_efecto  =dw_detalle.GetItemNumber(L[i],"anyo")
	orden_efecto =dw_detalle.GetItemNumber(L[i],"orden")
	UPDATE carefectos  
     SET situacion = "3",   
         efectoagrupa = :orden_nuevo,   
         anyoagrupa = :var_anyo  
     WHERE  ( carefectos.empresa = :codigo_empresa) AND
			   ( carefectos.anyo = :anyo_efecto ) AND
            ( carefectos.orden = :orden_efecto );
	IF SQLCA.SQLCODE <> 0 Then bien = 1
 	
next

//selecciono valores del registro con divisa mayor

string monedas,fpago,tipodoc,factura
string agente1,pais,cuenta,domiciliacion,observaciones,cliente
datetime fvto,ffra,fcobro
dec anyofra,recibo

Str_carefectos efecto   

	 SELECT carefectos.anyofra,carefectos.factura,carefectos.recibo,   
         carefectos.fvto,carefectos.ffra,carefectos.fcobro,carefectos.monedas,   
         carefectos.fpago,carefectos.tipodoc,carefectos.agente1,
			carefectos.pais,carefectos.cuenta,carefectos.domiciliacion,
			carefectos.Nacional,carefectos.observaciones,carefectos.cliente
    INTO :anyofra,:factura,:recibo,:fvto,:ffra,:fcobro,:monedas,:fpago,   
         :tipodoc,:agente1,:pais,:cuenta,:domiciliacion,:nacional,   
         :observaciones,:cliente
    FROM carefectos  
    WHERE ( carefectos.empresa = :codigo_empresa ) AND  
          ( carefectos.anyo = :var_anyo ) AND  
          ( carefectos.orden =:var_orden)   ;
			 
IF SQLCA.SQLCODE <> 0 Then bien = 1
 
//inserto nuevo registro
         
   		  efecto.empresa  =  codigo_empresa   
           efecto.anyo     =  var_anyo  
           efecto.orden    =  orden_nuevo 
           efecto.anyofra  =  anyofra 
//           efecto.factura  =  "AGRUPADO"
			  efecto.factura  =  cadena
           efecto.recibo   =  recibo
           efecto.fvto     =  fvto
           efecto.fvto_original =  fvto
           efecto.ffra     =  ffra
           efecto.fcobro   =  fcobro
           efecto.importe  =  total_imp  
           efecto.divisas  =  total_div 
			  if total_imp = 0 then
			  	efecto.cambio	=  1
			  else
				efecto.cambio	= 	total_div / total_imp
			  end if	
			  efecto.monedas  =  monedas 
           efecto.fpago    =  fpago
           efecto.tipodoc  =  tipodoc 
           setnull(efecto.banco)  
           setnull(efecto.remesa) 
           setnull(efecto.fremesa)
           efecto.situacion=  "0"   
           efecto.agente1  =  agente1  
           efecto.pais     =  pais
           efecto.cuenta   =  var_cuenta
			  
           efecto.domiciliacion= domiciliacion  
           efecto.nacional =  nacional 
           efecto.observaciones= observaciones 
           setnull(efecto.libre)
           setnull(efecto.gasto)
           setnull(efecto.fdevolucion)
           efecto.agrupado ="S"   
           setnull(efecto.efectoagrupa)
           setnull(efecto.anyoagrupa)
           efecto.cliente = cliente
			  setnull(efecto.anyo_remesa)
			  
IF Not f_insert_carefectos(efecto) Then bien = 1


If bien <> 0  Then
	RollBack;
	f_mensaje("Error en proceso","El proceso no se actualiza(" +sqlca.sqlerrtext+")")
ELSE
	Commit;
END IF

f_desbloquear(tabla,seleccion,titulo)
COMMIT;
// enlazo con el mantenimiento de efectos para que modifiquen lo que 
// quieran. Tal que tipodoc,f.vencimiento ,etc....
str_parametros lstr_param
str_parametros lstr_param1

lstr_param.i_nargumentos    = 4
lstr_param.s_argumentos[1]  = "wi_mant_carefectos"
lstr_param.s_argumentos[2]= String(efecto.anyo)
lstr_param.s_argumentos[3]= String(efecto.orden)
lstr_param.s_argumentos[4]= "V"
bien = OpenWithParm(wi_mant_carefectos,lstr_param)
lstr_param1 = Message.PowerObjectParm
end if

f_control()

//		FIN PROCESO DE AGRUPAR


END IF
end event

type st_2 from statictext within w_agrupacion_recibos
boolean visible = false
integer x = 64
integer y = 1372
integer width = 1984
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Estos son los recibos seleccionados.          ¿Continuar o Salir?"
boolean focusrectangle = false
end type

type st_3 from statictext within w_agrupacion_recibos
boolean visible = false
integer x = 64
integer y = 1372
integer width = 1984
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Desea desagrupar este recibo.                 ¿Continuar o Salir?"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_agrupacion_recibos
integer x = 18
integer y = 92
integer width = 1751
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_detalle from datawindow within w_agrupacion_recibos
integer x = 9
integer y = 236
integer width = 2853
integer height = 2672
string dataobject = "dw_agrupacion_recibos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;Integer linea
String agrupado
linea = row
if linea=0 then return
agrupado =  This.GetItemString(linea,"agrupado")

if agrupado="S" Then
	
   des_anyo =this.GetItemNumber(row,"anyo")
   des_orden=this.GetItemNumber(row,"orden")
	
	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(des_anyo)
   lstr_param.s_argumentos[3]=string(des_orden)

   OpenWithParm(w_detalle_agrupado,lstr_param)
  

End If
end event

event retrieveend;integer n,i
string agrupado

n=dw_detalle.rowcount()

for i=1 to n
	dw_detalle.setitem(i,"libre","N")
	agrupado =  This.GetItemString(i,"agrupado")
	if isnull(agrupado) or agrupado<>"S" then dw_detalle.setitem(i,"agrupado","N")
next

end event

event doubleclicked;if var_accion = "DESAGRUPAR" THEN RETURN
Integer linea
String marcado,agrupado,moneda
linea = row
if linea=0 then return
if var_marcados=0 then var_moneda=""

marcado  =  This.GetItemString(linea,"libre")
agrupado =  This.GetItemString(linea,"agrupado")
moneda   =  This.GetItemString(linea,"monedas")
if var_moneda="" then var_moneda=moneda

if agrupado="S" Then
	var_accion="DESAGRUPAR"
	des_anyo =  This.GetItemNumber(linea,"anyo")
	des_orden=  This.GetItemNumber(linea,"orden")
	cb_procesar.triggerevent(clicked!)
else
	IF marcado <> "S" then
		if moneda=var_moneda then
			This.SetItem(linea,"libre","S")
			var_marcados=var_marcados + 1
		Else
			messagebox("No puede marcarse.","El tipo de moneda no coincide.")
		end if
	Else
	   if marcado = "S" then
	  		this.SetItem(linea,"libre","N")
			var_marcados=var_marcados - 1
		end if
	End If
end if

end event

