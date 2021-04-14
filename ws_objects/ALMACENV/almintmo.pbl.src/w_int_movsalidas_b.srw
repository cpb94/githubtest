$PBExportHeader$w_int_movsalidas_b.srw
forward
global type w_int_movsalidas_b from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_movsalidas_b
end type
type dw_proceso from datawindow within w_int_movsalidas_b
end type
type dw_procesos from datawindow within w_int_movsalidas_b
end type
type st_1 from statictext within w_int_movsalidas_b
end type
type st_2 from statictext within w_int_movsalidas_b
end type
type st_3 from statictext within w_int_movsalidas_b
end type
type em_tono from u_em_campo within w_int_movsalidas_b
end type
type em_calibre from u_em_campo within w_int_movsalidas_b
end type
type st_4 from statictext within w_int_movsalidas_b
end type
type st_texto_cantidad from statictext within w_int_movsalidas_b
end type
type em_cantidad from u_em_campo within w_int_movsalidas_b
end type
type cb_1 from u_boton within w_int_movsalidas_b
end type
type uo_articulo from u_em_campo_2 within w_int_movsalidas_b
end type
type uo_calidad from u_em_campo_2 within w_int_movsalidas_b
end type
type st_texto_cajas from statictext within w_int_movsalidas_b
end type
type st_texto_pallet from statictext within w_int_movsalidas_b
end type
type em_cajas from u_em_campo within w_int_movsalidas_b
end type
type em_pallet from u_em_campo within w_int_movsalidas_b
end type
type st_disponible from statictext within w_int_movsalidas_b
end type
type em_disponible from statictext within w_int_movsalidas_b
end type
type dw_almlinubicahis from datawindow within w_int_movsalidas_b
end type
type st_5 from statictext within w_int_movsalidas_b
end type
type dw_listado from datawindow within w_int_movsalidas_b
end type
type dw_2 from datawindow within w_int_movsalidas_b
end type
type dw_1 from datawindow within w_int_movsalidas_b
end type
type em_fechadesde from u_em_campo within w_int_movsalidas_b
end type
type em_fechahasta from u_em_campo within w_int_movsalidas_b
end type
type st_10 from statictext within w_int_movsalidas_b
end type
end forward

global type w_int_movsalidas_b from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2921
integer height = 1568
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
pb_1 pb_1
dw_proceso dw_proceso
dw_procesos dw_procesos
st_1 st_1
st_2 st_2
st_3 st_3
em_tono em_tono
em_calibre em_calibre
st_4 st_4
st_texto_cantidad st_texto_cantidad
em_cantidad em_cantidad
cb_1 cb_1
uo_articulo uo_articulo
uo_calidad uo_calidad
st_texto_cajas st_texto_cajas
st_texto_pallet st_texto_pallet
em_cajas em_cajas
em_pallet em_pallet
st_disponible st_disponible
em_disponible em_disponible
dw_almlinubicahis dw_almlinubicahis
st_5 st_5
dw_listado dw_listado
dw_2 dw_2
dw_1 dw_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_10 st_10
end type
global w_int_movsalidas_b w_int_movsalidas_b

type variables
  integer contador
  integer v_fila,v_altura,anyo
  String v_almacen
  string   v_zona,v_familia,v_sector,var_externo
  decimal{4} v_cantidad
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono

boolean control_tono,control_calibre
  




end variables

forward prototypes
public function boolean f_control_disponible_ubicacion ()
public subroutine f_control_tono_calibre ()
public subroutine aa ()
end prototypes

public function boolean f_control_disponible_ubicacion ();decimal{4} var_cantidad,total_cantidad,cur_existencias
string var_referencia,var_ubicacion,cur_empresa
Integer cur_pedido,cur_linea,salir
String  cur_ubicacion,cur_referencia

total_cantidad=0
var_ubicacion=f_componer_ubicacion(dw_2.GetItemString(dw_2.GetRow(),"almacen"),&
                                   dw_2.GetItemString(dw_2.GetRow(),"zona"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"fila"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"altura"))
                                     
  var_referencia=f_componer_ref(uo_articulo.em_codigo.text,&
                                uo_calidad.em_codigo.text,&
                                Trim(em_tono.text),&
                                Integer(em_calibre.text))



 Integer registros
 registros=dw_proceso.Retrieve(codigo_empresa,var_ubicacion,var_referencia)
 IF registros<>0 THEN
  FOR x= 1 TO registros
    cur_existencias = dw_proceso.GetItemNumber(x,"existencias")
    cur_pedido      = dw_proceso.GetItemNumber(x,"pedido")
    IF IsNull(cur_pedido) or trim(string(cur_pedido))="" THEN
       total_cantidad=cur_existencias + total_cantidad
    END IF
  NEXT
 END IF

IF Dec(em_cantidad.text) > total_cantidad THEN
 MessageBox("No Hay Stock suficiente en esta ubicacion","La cantidad no puede superar a " + string(total_cantidad),Exclamation!, OK!,1)
 em_cantidad.text=String(total_cantidad)
 Return false
END IF

IF Dec(em_cantidad.text) > Dec(em_disponible.text) THEN
 MessageBox("No Hay Disponible suficiente","La cantidad no puede superar a " + string(em_disponible.text),Exclamation!, OK!,1)
 em_cantidad.text=String(em_disponible)
 Return false
END IF

REturn TRUE
end function

public subroutine f_control_tono_calibre (); control_tono    =  TRUE
 control_calibre =  TRUE

 IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_tono   =  FALSE
 	em_tono.text       =  ""
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text    =  "0"
 END IF  

end subroutine

public subroutine aa ();////CONTROLES DE VALORES
//f_control_tono_calibre()
//
//dec  nummov
//dec  cantidad
//string almacen
//
//string mensaje
//Dec{2}  var_conjunto
//
//if dw_1.getrow() = 0 then
//	MessageBox("Atención","Debe marcar la entrada sobre la cual descontar.")
//	Return
//end if
//
//
//cantidad = dw_1.object.cantidade[dw_1.getrow()]
//
//if cantidad < Dec(em_cantidad.text) then
//	MessageBox("Atención","Debe marcar una entrada de mayoy o igual cantidad a la salida a realizar.")
//	Return	
//end if
//
//if var_externo="N" then
//	if MessageBox("Control tipo de almacen","El material no esta en un almacen de carga directa.¿Desea continuar?",Question!,YesNo!,2)=2 then 
//	   em_cantidad.SetFocus()
//		Return
//   End if
//End if
//
//IF trim(uo_articulo.em_campo.text)="" THEN
//   mensaje="Introduzca el articulo"
//   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
//   uo_articulo.em_campo.Setfocus()
//   RETURN
//END IF
//IF v_sector = "S" THEN
//  IF trim(uo_calidad.em_campo.text)="" THEN
//		mensaje="Introduzca la calidad"
//		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//		uo_calidad.em_campo.Setfocus()
//		RETURN 
//  END IF
//  IF control_tono=TRUE Then
//	 IF trim(em_tono.text)="" THEN
//		mensaje="Introduzca el tono"
//		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//		em_tono.SetFocus()
//		RETURN
//	 END IF
//  END IF
//  IF control_calibre=TRUE Then
//	 IF trim(em_calibre.text)="" THEN
//		mensaje="Introduzca el calibre"
//		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//		em_calibre.SetFocus()
//		RETURN
//	 END IF
//  END IF
//END IF
//
//IF dw_2.GetRow() =0 Then
//   mensaje="Marcar Una Ubicacion"
//   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//   dw_2.SetFocus()
//   RETURN
//END IF
//
//// control bloqueo promocion
//string v_ubicacion
//dec v_linea
//v_ubicacion = dw_2.GetItemString(dw_2.getRow(),"ubicacion")
//v_linea     = dw_2.GetItemNumber(dw_2.getRow(),"linea")
//if f_bloqueo_almlinubica_promocion(codigo_empresa,v_ubicacion,v_linea) then
//   f_mensaje("!Atención¡","Material bloqueado modulo promocion")
//	Return
//End if
//
//// control bloqueo material
//if f_bloqueo_almlinubica(codigo_empresa,v_ubicacion,v_linea) then
//   f_mensaje("!Atención¡","Material bloqueado" )
//	Return
//End if
//
//
//IF v_sector = "S" THEN
//	string codigo_articulo
//	String codigo_calidad
//	
//	codigo_articulo=uo_articulo.em_codigo.text
//	codigo_calidad= uo_calidad.em_codigo.text
//	
//	SELECT almartcal.calidad 
//	INTO   :codigo_calidad
//	FROM   almartcal  
//	WHERE  (almartcal.empresa  = :codigo_empresa)
//	AND    (almartcal.articulo = :codigo_articulo)
//	AND    (almartcal.calidad  = :codigo_calidad);
//	
//	IF SQLCA.SQLCode<>0 THEN
//		MessageBox("Calidad no  valida","Esta calidad no esta definida para el artículo",Exclamation!, OK!,1)
//		uo_calidad.em_campo.text        = ""
//		uo_calidad.em_codigo.text = ""
//		uo_calidad.em_campo.Setfocus()
//		Return
//	END IF
//END IF
//
//// controlo las exitencias disponibles
//
//// IF Not f_control_disponible_ubicacion() Then
//IF Dec(em_cantidad.text) > dw_2.GetItemNumber(dw_2.GetRow(),"existencias") then
//	f_mensaje("Advertencia","No existen existencias suficientes")
//	f_activar_campo(em_cantidad)
//	Return
//END IF
//
//IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
//	mensaje="Introduzca nº total de cantidad"
//	MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//	em_cantidad.SetFocus()
//	RETURN
//END IF
//
//// Control piezas por conjunto
//var_conjunto = f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
//IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
//	IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
//		MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
//		f_activar_campo(em_cantidad)
//		return
//	END IF
//END IF
//
//
//IF Not f_bloquear_almacen(w_int_movsalidas_b.title) Then
//	//----------------------//
//	// Proceso de Insercion //
//	//----------------------//
//	//---------------------------------------------------------------------
//	// Despues de todos los controles empezamos el proceso de inserción
//	//---------------------------------------------------------------------
//	// Valor de control funcionamiento
//	dec bien
//	//------------------------------------------------------------------------
//	// Valores fijos para todos los casos
//	//------------------------------------------------------------------------
//	ubihis.usuario       = nombre_usuario
//	ubihis.empresa       = codigo_empresa
//	ubihis.anyo          = year(today())
//	ubihis.almacen       = dw_2.GetItemString(dw_2.getRow(),"almacen")
//	ubihis.articulo      = uo_articulo.em_codigo.text
//	ubihis.calidad       = uo_calidad.em_codigo.text
//	ubihis.tonochar      = Trim(em_tono.text)
//	ubihis.calibre       = dec(em_calibre.text)
//	ubihis.fecha         = Datetime(today(),now())
//	ubihis.f_alta        = Datetime(today(),now())
//	ubihis.observaciones = sle_observaciones.text
//	ubihis.tipomov       = "B"
//	ubihis.tipo_pallet   = dw_2.GetItemString(dw_2.getRow(),"tipo_pallet")
//	ubihis.caja          = dw_2.GetItemString(dw_2.getRow(),"caja")
//	ubihis.sector        = v_sector
//	
//	SELECT  articulos.empresa,
//	        articulos.codigo,
//			  articulos.familia,   
//	        articulos.formato,
//			  articulos.modelo,
//			  articulos.unidad  
//	INTO    :ubihis.empresa,
//	        :ubihis.articulo,
//			  :ubihis.familia,
//			  :ubihis.formato,   
//	        :ubihis.modelo,
//			  :ubihis.tipo_unidad  
//	FROM    articulos  
//	WHERE   (articulos.empresa = :ubihis.empresa ) AND  
//	        (articulos.codigo  = :ubihis.articulo ) ;
//	
//	IF SQLCA.SQLCode<>0 THEN bien=1
//	ubihis.referencia   = f_componer_ref(ubihis.articulo,&
//				             	ubihis.calidad,ubihis.tonochar,&
//				  					ubihis.calibre)
//	ubi.empresa     =  ubihis.empresa
//	ubi.almacen     =  ubihis.almacen
//	ubi.articulo    =  ubihis.articulo
//	ubi.familia     =  ubihis.familia
//	ubi.formato     =  ubihis.formato
//	ubi.modelo      =  ubihis.modelo
//	ubi.calidad     =  ubihis.calidad
//	ubi.tonochar    =  ubihis.tonochar
//	ubi.calibre     =  ubihis.calibre
//	ubi.tipo_pallet =  ubihis.tipo_pallet
//	ubi.caja        =  ubihis.caja
//	ubi.sector      =  ubihis.sector
//	SetNull(ubi.anyo)
//	SetNull(ubi.pedido) 
//	SetNull(ubi.linped)
//	SetNull(ubi.cliente)
//	ubi.tipo_unidad  =  ubihis.tipo_unidad
//	ubi.referencia   =  ubihis.referencia
//	ubi.f_alta       =  DateTime(today(),now())
//	ubihis.zona      =  dw_2.GetItemString(dw_2.GetRow(),"zona")
//	ubihis.fila      =  dw_2.GetItemNumber(dw_2.GetRow(),"fila")
//	ubihis.altura    =  dw_2.GetItemNumber(dw_2.GetRow(),"altura")
//	ubihis.cantidads =  Dec(em_cantidad.text)
//	ubihis.cantidade = 0
//	
//	ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//							  		ubihis.fila,ubihis.altura)
//	ubi.zona            = ubihis.zona
//	ubi.fila            = ubihis.fila
//	ubi.altura          = ubihis.altura
//	ubi.existencias     = ubihis.cantidads
//	ubi.ubicacion       = ubihis.ubicacion
//	
//	mov.empresa          = ubihis.empresa
//	mov.almacen          = ubihis.almacen
//	mov.anyo             = ubihis.anyo
//	mov.origen           = "4"
//	mov.articulo         = ubihis.articulo
//	mov.fechmov          = ubihis.fecha
//	mov.tipomov          = ubihis.tipomov
//	mov.cantidade        = ubihis.cantidade
//	mov.cantidads        = ubihis.cantidads
//	setnull(mov.precio)
//	setnull(mov.codtercero)
//	setnull(mov.numdoc)
//	//Lo grabamos en situación anulado  
//	mov.situacion        = "A"
//	mov.observaciones    = ubihis.observaciones
//	SetNull(mov.punteado)
//	mov.antexist         = 0      
//	mov.familia          = ubihis.familia
//	mov.formato          = ubihis.formato
//	mov.modelo           = ubihis.modelo
//	mov.calidad          = ubihis.calidad
//	mov.tonochar         = ubihis.tonochar
//	mov.calibre          = ubihis.calibre
//	mov.tipo_unidad      = ubihis.tipo_unidad
//	mov.tipo_pallet      = ubihis.tipo_pallet
//	mov.caja             = ubihis.caja
//	mov.referencia       = ubihis.referencia
//	mov.f_alta           = DateTime(today(),now())
//	mov.sector           = v_sector
//	//-------------------------------------------------------------------
//	v_almacen = dw_2.GetItemString(dw_2.GetRow(),"almacen")
//	
//	ubihis.orden   = f_almparam_numorden(codigo_empresa,Year(today()))
//	ubihis.nummov  = f_almparam_nummov(codigo_empresa,Year(today()))
//	mov.nummov     = ubihis.nummov    
//	// Variables para cargar el cursor
//	
//	dec cur_pedido,cur_linea,cur_anyo
//	String  cur_empresa,cur_almacen
//	
//	decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada
//	string  cur_referencia,cur_ubicacion,cur_tipo_pallet,cur_caja
//	
//	
//	// Primero actualizo la salida global //
//	//-------------------------------------//
//	// En el historico de ubicaciones
//	//IF NOT f_insert_almlinubicahis(ubihis) Then  bien=1
//	//IF NOT f_actualiza_numorden(codigo_empresa,Year(today()),ubihis.orden) THEN
//	//	bien=1
//	//END IF
//	//----------------------------------------------
//	// Borro en las ubicaciones correspondientes
//	//----------------------------------------------
//	
//	dec Registros,x1=0
//	registros = dw_proceso.retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubi.caja)
//	cantidad_borrada=0
//	If registros<>0 Then
//		For x1 = 1 To Registros
//			cur_pedido        =  dw_proceso.GetItemNumber(x1,"pedido")
//			cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
//			cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
//			cur_tipo_pallet   =  dw_proceso.GetItemString(x1,"tipo_pallet")
//			cur_caja          =  dw_proceso.GetItemString(x1,"caja")
//			
//			IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet=ubi.tipo_pallet) and (cur_caja=ubi.caja) THEN
//				cantidad_pendiente=Dec(em_cantidad.text) - cantidad_borrada
//				IF cantidad_pendiente = 0 THEN   EXIT
//				IF cantidad_pendiente >= cur_existencias THEN 
//					cantidad_borrada = cantidad_borrada + cur_existencias
//					
//					DELETE FROM almlinubica
//					WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//					      ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//					      ( almlinubica.linea     = :cur_linea ) USING SQLCA   ;
//							
//					IF SQLCA.SQLCode<>0 THEN bien=1
//				ELSE
//					cur_existencias  = cur_existencias - cantidad_pendiente
//					cantidad_borrada = cantidad_borrada + cantidad_pendiente
//					
//					UPDATE almlinubica  
//					SET    existencias = :cur_existencias  
//					WHERE  (almlinubica.empresa   = :ubi.empresa ) AND  
//					       (almlinubica.ubicacion = :ubi.ubicacion ) AND  
//					       (almlinubica.linea     = :cur_linea )USING SQLCA;
//							 
//					IF SQLCA.SQLCode<>0 THEN bien=1
//					
//				END IF
//			END IF
//		NEXT
//	END IF
//	
//	IF cantidad_borrada <> Dec(em_cantidad.text) THEN  bien=1
//	
//	
//	// Grabo el movimiento en el historico
//	//IF NOT f_insert_almmovhis(mov) Then bien=1
//	//IF NOT f_actualiza_nummov(mov.empresa,mov.anyo,mov.nummov) THEN  bien=1
//	
//	//Quito la cantidad de la entrada de producción seleccionada
//	
//	cantidad = dw_1.object.cantidade[dw_1.getrow()]
//	almacen  = dw_1.object.almacen[dw_1.getrow()]
//	anyo     = dw_1.object.anyo[dw_1.getrow()]
//	nummov   = dw_1.object.nummov[dw_1.getrow()]
//	
//	cantidad = cantidad - mov.cantidads
//
//	update almmovhis
//	set    cantidade   = :cantidad
//	where  empresa     = :codigo_empresa
//	and    almacen     = :almacen
//	and    anyo        = :anyo
//	and    nummov      = :nummov;
//	
//	if sqlca.sqlcode <> 0 then
//		bien = 1
//		messagebox("Atención","Se ha producido un error actualizando almmovhis")
//	end if
//
//	CHOOSE CASE bien
//		CASE 1
//			ROLLBACK USING SQLCA;
//			MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
//		CASE 0
//			COMMIT USING SQLCA;
//		CASE ELSE
//			ROLLBACK USING SQLCA;
//			MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
//	END CHOOSE
//	f_desbloquear_almacen(w_int_movsalidas_b.title)
//	pb_1.enabled=TRUE
//	em_calibre.text=""
//	em_cantidad.text=""
//	em_tono.text=""
//	em_pallet.text=""
//	em_cajas.text=""
//	uo_articulo.em_campo.text=""
//	uo_calidad.em_campo.text=""
//	uo_articulo.em_codigo.text=""
//	em_disponible.text = ""
//	dw_2.retrieve(codigo_empresa,"")
//	uo_articulo.em_campo.SetFocus()
//END IF
end subroutine

event ue_f6;call super::ue_f6;//IF pb_imprimir.visible = FALSE  Then   Return
em_disponible.TriggerEvent(clicked!)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="XX Introducción Movimientos Salidas Almacen XX"
This.title=istr_parametros.s_titulo_ventana

dw_2.settransobject(SQLCA)
dw_1.settransobject(SQLCA)

dw_proceso.SetTransObject(SQLCA)
dw_almlinubicahis.SetTransObject(SQLCA)

em_fechadesde.setfocus()





end event

on w_int_movsalidas_b.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_proceso=create dw_proceso
this.dw_procesos=create dw_procesos
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_4=create st_4
this.st_texto_cantidad=create st_texto_cantidad
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.st_texto_cajas=create st_texto_cajas
this.st_texto_pallet=create st_texto_pallet
this.em_cajas=create em_cajas
this.em_pallet=create em_pallet
this.st_disponible=create st_disponible
this.em_disponible=create em_disponible
this.dw_almlinubicahis=create dw_almlinubicahis
this.st_5=create st_5
this.dw_listado=create dw_listado
this.dw_2=create dw_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_10=create st_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_procesos
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_tono
this.Control[iCurrent+8]=this.em_calibre
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_texto_cantidad
this.Control[iCurrent+11]=this.em_cantidad
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.uo_calidad
this.Control[iCurrent+15]=this.st_texto_cajas
this.Control[iCurrent+16]=this.st_texto_pallet
this.Control[iCurrent+17]=this.em_cajas
this.Control[iCurrent+18]=this.em_pallet
this.Control[iCurrent+19]=this.st_disponible
this.Control[iCurrent+20]=this.em_disponible
this.Control[iCurrent+21]=this.dw_almlinubicahis
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.dw_listado
this.Control[iCurrent+24]=this.dw_2
this.Control[iCurrent+25]=this.dw_1
this.Control[iCurrent+26]=this.em_fechadesde
this.Control[iCurrent+27]=this.em_fechahasta
this.Control[iCurrent+28]=this.st_10
end on

on w_int_movsalidas_b.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_proceso)
destroy(this.dw_procesos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_4)
destroy(this.st_texto_cantidad)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.st_texto_cajas)
destroy(this.st_texto_pallet)
destroy(this.em_cajas)
destroy(this.em_pallet)
destroy(this.st_disponible)
destroy(this.em_disponible)
destroy(this.dw_almlinubicahis)
destroy(this.st_5)
destroy(this.dw_listado)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_10)
end on

event activate;call super::activate;w_int_movsalidas_b = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movsalidas_b
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movsalidas_b
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movsalidas_b
integer x = 18
integer y = 16
integer width = 2674
integer height = 96
end type

type pb_1 from upb_salir within w_int_movsalidas_b
integer x = 2720
integer y = 12
integer width = 119
integer height = 100
integer taborder = 0
alignment htextalign = right!
end type

type dw_proceso from datawindow within w_int_movsalidas_b
boolean visible = false
integer width = 649
integer height = 160
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type dw_procesos from datawindow within w_int_movsalidas_b
boolean visible = false
integer width = 654
integer height = 168
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type st_1 from statictext within w_int_movsalidas_b
integer x = 9
integer y = 364
integer width = 594
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_movsalidas_b
integer x = 603
integer y = 364
integer width = 91
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_movsalidas_b
integer x = 695
integer y = 364
integer width = 165
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_movsalidas_b
integer x = 695
integer y = 440
integer width = 165
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "!!!!"
end type

on getfocus;call u_em_campo::getfocus;ante_tono = em_tono.text
end on

on modificado;call u_em_campo::modificado;// Visualiza las lineas de ubicación a nivel de articulo-calidad-tono

if ante_tono<>em_tono.text then
   if trim(em_tono.text)<>"" THEN
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then

      is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"	
      is_filtro = is_filtro + " AND tono = " + em_tono.text  
  
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
    End If

  End If
End if
end on

type em_calibre from u_em_campo within w_int_movsalidas_b
integer x = 859
integer y = 440
integer width = 69
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = numericmask!
string mask = "0"
end type

type st_4 from statictext within w_int_movsalidas_b
integer x = 859
integer y = 364
integer width = 69
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_movsalidas_b
integer x = 2533
integer y = 364
integer width = 320
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_movsalidas_b
integer x = 2528
integer y = 440
integer width = 325
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;string cadena
em_pallet.text= ""
em_cajas.text = ""

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_pallet.text       =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_cantidad.text     =Mid(cadena,19,9)


end event

type cb_1 from u_boton within w_int_movsalidas_b
integer x = 2656
integer y = 540
integer width = 201
integer height = 116
integer taborder = 120
string text = "&Ok"
end type

event clicked;dec     cur_pedido,cur_linea,cur_anyo,bien,v_linea,var_conjunto
String  cur_empresa,cur_almacen,mensaje,v_ubicacion
string  codigo_articulo,codigo_calidad,tipo_pallet
string  almacen,articulo,calidad,tonochar,caja,referencia
string  zona,ubicacion
dec     fila,altura
decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada,salida,cantidad
string  cur_referencia,cur_ubicacion,cur_tipo_pallet,cur_caja
dec     Registros,x1=0,nummov,calibre


//CONTROLES DE VALORES
f_control_tono_calibre()

if dw_1.getrow() = 0 then
	MessageBox("Atención","Debe marcar la entrada sobre la cual descontar.")
	Return
end if

cantidad = dw_1.object.cantidade[dw_1.getrow()]
salida   = Dec(em_cantidad.text)
if cantidad < salida then
	MessageBox("Atención","Debe marcar una entrada de mayor o igual cantidad a la salida a realizar.")
	em_cantidad.SetFocus()
	Return	
end if

if var_externo="N" then
	if MessageBox("Control tipo de almacen","El material no esta en un almacen de carga directa.¿Desea continuar?",Question!,YesNo!,2)=2 then 
	   em_cantidad.SetFocus()
		Return
   End if
End if

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF
IF v_sector = "S" THEN
  IF trim(uo_calidad.em_campo.text)="" THEN
		mensaje="Introduzca la calidad"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		uo_calidad.em_campo.Setfocus()
		RETURN 
  END IF
  IF control_tono=TRUE Then
	 IF trim(em_tono.text)="" THEN
		mensaje="Introduzca el tono"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		em_tono.SetFocus()
		RETURN
	 END IF
  END IF
  IF control_calibre=TRUE Then
	 IF trim(em_calibre.text)="" THEN
		mensaje="Introduzca el calibre"
		MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
		em_calibre.SetFocus()
		RETURN
	 END IF
  END IF
END IF

IF dw_2.GetRow() =0 Then
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
   RETURN
END IF

// control bloqueo promocion

v_ubicacion = dw_2.GetItemString(dw_2.getRow(),"ubicacion")
v_linea     = dw_2.GetItemNumber(dw_2.getRow(),"linea")
if f_bloqueo_almlinubica_promocion(codigo_empresa,v_ubicacion,v_linea) then
   f_mensaje("!Atención¡","Material bloqueado modulo promocion")
	Return
End if

// control bloqueo material
if f_bloqueo_almlinubica(codigo_empresa,v_ubicacion,v_linea) then
   f_mensaje("!Atención¡","Material bloqueado" )
	Return
End if


IF v_sector = "S" THEN
	
	codigo_articulo = uo_articulo.em_codigo.text
	codigo_calidad  = uo_calidad.em_codigo.text
	
	SELECT almartcal.calidad 
	INTO   :codigo_calidad
	FROM   almartcal  
	WHERE  (almartcal.empresa  = :codigo_empresa)
	AND    (almartcal.articulo = :codigo_articulo)
	AND    (almartcal.calidad  = :codigo_calidad);
	
	IF SQLCA.SQLCode<>0 THEN
		MessageBox("Calidad no  valida","Esta calidad no esta definida para el artículo",Exclamation!, OK!,1)
		uo_calidad.em_campo.text  = ""
		uo_calidad.em_codigo.text = ""
		uo_calidad.em_campo.Setfocus()
		Return
	END IF
END IF

// controlo las exitencias disponibles

// IF Not f_control_disponible_ubicacion() Then
IF Dec(em_cantidad.text) > dw_2.GetItemNumber(dw_2.GetRow(),"existencias") then
	f_mensaje("Advertencia","No existen existencias suficientes")
	f_activar_campo(em_cantidad)
	Return
END IF

IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
	mensaje="Introduzca nº total de cantidad"
	MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
	em_cantidad.SetFocus()
	RETURN
END IF

// Control piezas por conjunto
var_conjunto = f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
	IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
		MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
		f_activar_campo(em_cantidad)
		return
	END IF
END IF

IF Not f_bloquear_almacen(w_int_movsalidas_b.title) Then
	
	articulo      = uo_articulo.em_codigo.text
	calidad       = uo_calidad.em_codigo.text
	tonochar      = Trim(em_tono.text)
	calibre       = dec(em_calibre.text)
	tipo_pallet   = dw_2.GetItemString(dw_2.getRow(),"tipo_pallet")
	caja          = dw_2.GetItemString(dw_2.getRow(),"caja")

	
	referencia   = f_componer_ref(articulo,calidad,tonochar,calibre)
									  
	almacen   = dw_2.GetItemString(dw_2.getRow(),"almacen")
	zona      = dw_2.GetItemString(dw_2.GetRow(),"zona")
	fila      = dw_2.GetItemNumber(dw_2.GetRow(),"fila")
	altura    = dw_2.GetItemNumber(dw_2.GetRow(),"altura")

	ubicacion = f_componer_ubicacion(almacen,zona,fila,altura)
	
	// Variables para cargar el cursor
	
	registros = dw_proceso.retrieve(codigo_empresa,ubicacion,referencia,caja)
	cantidad_borrada = 0
	If registros <> 0 Then
		For x1 = 1 To Registros
			cur_pedido        =  dw_proceso.GetItemNumber(x1,"pedido")
			cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
			cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
			cur_tipo_pallet   =  dw_proceso.GetItemString(x1,"tipo_pallet")
			cur_caja          =  dw_proceso.GetItemString(x1,"caja")
			
			IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet = tipo_pallet) and (cur_caja = caja) THEN
				cantidad_pendiente = Dec(em_cantidad.text) - cantidad_borrada
				IF cantidad_pendiente = 0 THEN   EXIT
				IF cantidad_pendiente >= cur_existencias THEN 
					cantidad_borrada = cantidad_borrada + cur_existencias
					
					DELETE FROM almlinubica
					WHERE ( almlinubica.empresa   = :codigo_empresa ) AND  
					      ( almlinubica.ubicacion = :ubicacion ) AND  
					      ( almlinubica.linea     = :cur_linea ) USING SQLCA   ;
							
					IF SQLCA.SQLCode<>0 THEN bien=1
				ELSE
					cur_existencias  = cur_existencias - cantidad_pendiente
					cantidad_borrada = cantidad_borrada + cantidad_pendiente
					
					UPDATE almlinubica  
					SET    existencias = :cur_existencias  
					WHERE  (almlinubica.empresa   = :codigo_empresa ) AND  
					       (almlinubica.ubicacion = :ubicacion ) AND  
					       (almlinubica.linea     = :cur_linea )USING SQLCA;
							 
					IF SQLCA.SQLCode<>0 THEN bien=1
					
				END IF
			END IF
		NEXT
	END IF
	
	IF cantidad_borrada <> Dec(em_cantidad.text) THEN  bien=1
	//Quito la cantidad de la entrada de producción seleccionada
	
	cantidad = dw_1.object.cantidade[dw_1.getrow()]
	almacen  = dw_1.object.almacen[dw_1.getrow()]
	anyo     = dw_1.object.anyo[dw_1.getrow()]
	nummov   = dw_1.object.nummov[dw_1.getrow()]
	
	cantidad = cantidad - salida
	if cantidad > 0 then	
		update almmovhis
		set    cantidade   = :cantidad
		where  empresa     = :codigo_empresa
		and    almacen     = :almacen
		and    anyo        = :anyo
		and    nummov      = :nummov;
	else
		delete almmovhis
		where  empresa     = :codigo_empresa
		and    almacen     = :almacen
		and    anyo        = :anyo
		and    nummov      = :nummov;		
	end if
	
	if sqlca.sqlcode <> 0 then
		bien = 1
		messagebox("Atención","Se ha producido un error actualizando almmovhis")
	end if

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
	f_desbloquear_almacen(w_int_movsalidas_b.title)
	pb_1.enabled=TRUE
	em_calibre.text=""
	em_cantidad.text=""
	em_tono.text=""
	em_pallet.text=""
	em_cajas.text=""
	uo_articulo.em_campo.text=""
	uo_calidad.em_campo.text=""
	uo_articulo.em_codigo.text=""
	em_disponible.text = ""
	dw_2.reset()
	dw_1.reset()
	uo_articulo.em_campo.SetFocus()
END IF
end event

type uo_articulo from u_em_campo_2 within w_int_movsalidas_b
integer x = 9
integer y = 440
integer width = 594
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion

select descripcion,familia,unidad
Into   :var_descripcion,:v_familia,:var_tipo_unidad
from   articulos
Where  articulos.empresa  =  :codigo_empresa
And    articulos.codigo   =  :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = var_descripcion
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
	 uo_articulo.em_campo.text=""
	 uo_articulo.em_codigo.text=""
	 uo_articulo.em_campo.SetFocus()
	 Return
 End if
END IF


// Visualiza las lineas de ubicación a nivel de articulo

   If trim(uo_articulo.em_campo.text)<>"" Then
      STRING is_filtro = ""
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()  
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
   End If

   st_texto_cantidad.text=f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
	em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))
	f_mascara_columna(dw_2,"existencias",f_mascara_unidad(var_tipo_unidad))
   v_sector  = f_sector_familia(codigo_empresa,v_familia)
   

end event

on getfocus;call u_em_campo_2::getfocus;ante_codigo_articulo = uo_articulo.em_codigo.text

ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_movsalidas_b
integer x = 603
integer y = 440
integer width = 91
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo-calidad

if ante_codigo_calidad<>uo_calidad.em_codigo.text Then

   if trim(uo_calidad.em_campo.text)<>"" Then
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then
       	is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"
	      dw_2.SetFilter(is_filtro)
         dw_2.Filter()
         dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
      End If
    End If
End if
end on

on getfocus;call u_em_campo_2::getfocus;ante_codigo_calidad = uo_calidad.em_codigo.text

ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type st_texto_cajas from statictext within w_int_movsalidas_b
integer x = 2350
integer y = 364
integer width = 183
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_pallet from statictext within w_int_movsalidas_b
integer x = 2245
integer y = 364
integer width = 101
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cajas from u_em_campo within w_int_movsalidas_b
integer x = 2345
integer y = 440
integer width = 187
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_pallet.text       =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_cantidad.text     =Mid(cadena,19,9)


end event

type em_pallet from u_em_campo within w_int_movsalidas_b
integer x = 2245
integer y = 440
integer width = 101
integer taborder = 90
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###0"
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;//TriggerEvent("modificado")
//call super::getfocus

end event

event modificado;call super::modificado;string cadena

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_pallet.text       =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_cantidad.text     =Mid(cadena,19,9)


end event

type st_disponible from statictext within w_int_movsalidas_b
fontcharset fontcharset = ansi!
string facename = "System"
end type

type em_disponible from statictext within w_int_movsalidas_b
integer x = 2254
integer y = 728
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 12632256
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_almlinubicahis from datawindow within w_int_movsalidas_b
boolean visible = false
integer x = 165
integer y = 992
integer width = 1143
integer height = 496
integer taborder = 170
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_movsalidas4"
boolean controlmenu = true
boolean vscrollbar = true
end type

type st_5 from statictext within w_int_movsalidas_b
integer x = 2254
integer y = 652
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 12632256
boolean enabled = false
string text = "Disponible"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_int_movsalidas_b
boolean visible = false
integer x = 658
integer width = 494
integer height = 156
integer taborder = 160
boolean bringtotop = true
string dataobject = "report_int_movsalidas"
boolean livescroll = true
end type

type dw_2 from datawindow within w_int_movsalidas_b
event key pbm_dwnkey
integer x = 928
integer y = 364
integer width = 1317
integer height = 448
integer taborder = 80
string dataobject = "dw_int_movsalidas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;String referencia,tipo_pallet
IF this.getRow()<>0 THEN
 integer registros
 long linea
 linea     = dw_2.GetRow() 
 
 IF linea<>0 THEN
    registros = dw_2.RowCount()
    IF registros>0 THEN
      em_cantidad.text=String(GetItemNumber(GetRow(),"existencias"))
		em_pallet.text= ""
      em_cajas.text = ""    
    End If
    This.SelectRow(0,FALSE)
    This.SelectRow(getRow(),TRUE)
      uo_calidad.em_codigo.text =  GetItemString(dw_2.getRow(),"calidad")
      em_tono.text              =  String(GetItemString(dw_2.getRow(),"tonochar"))
      em_calibre.text           =  String(GetItemNumber(dw_2.getRow(),"calibre"))
		var_externo               =  String(GetItemString(dw_2.getRow(),"externo"))
		uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

      referencia = This.getItemString(This.GetRow(),"referencia")
      tipo_pallet = This.getItemString(This.GetRow(),"tipo_pallet")
      
      em_disponible.text = String(f_disponible_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet))
      
      
  End If
End IF
 


end event

on getfocus;This.TriggerEvent(RowFocusChanged!)
end on

event clicked;string articulo,calidad,tono,tipo_pallet,caja
dec    calibre
datetime f_desde,f_hasta

if row <> 0 then
	articulo    = this.object.articulo[row]	
	calidad     = this.object.calidad[row]
	tono        = this.object.tonochar[row]
	calibre     = this.object.calibre[row]
	tipo_pallet = this.object.tipo_pallet[row]
	caja        = this.object.caja[row]
	f_desde     = datetime(date(em_fechadesde.text))
	f_hasta     = datetime(date(em_fechahasta.text))
	dw_1.retrieve(codigo_empresa,f_desde,f_hasta,articulo,calidad,tono,calibre,tipo_pallet,caja)
end if

end event

type dw_1 from datawindow within w_int_movsalidas_b
integer x = 649
integer y = 820
integer width = 1906
integer height = 528
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_con_movimientos_entrada"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row <> 0 then
	This.SelectRow(0,FALSE)
	This.SetRow(row)
	This.SelectRow(row,TRUE)
end if
end event

type em_fechadesde from u_em_campo within w_int_movsalidas_b
integer x = 9
integer y = 260
integer width = 293
integer height = 76
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_int_movsalidas_b
integer x = 315
integer y = 260
integer width = 288
integer height = 76
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_10 from statictext within w_int_movsalidas_b
integer x = 9
integer y = 184
integer width = 594
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fechas de Entradas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

