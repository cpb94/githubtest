$PBExportHeader$w_int_movalm_compras.srw
forward
global type w_int_movalm_compras from w_int_con_empresa
end type
type st_13 from statictext within w_int_movalm_compras
end type
type st_12 from statictext within w_int_movalm_compras
end type
type st_11 from statictext within w_int_movalm_compras
end type
type st_texto_cantidad from statictext within w_int_movalm_compras
end type
type st_2 from statictext within w_int_movalm_compras
end type
type st_nombre_tipomov from statictext within w_int_movalm_compras
end type
type st_9 from statictext within w_int_movalm_compras
end type
type st_proveedor_etiqueta from statictext within w_int_movalm_compras
end type
type st_nombre_proveedor from statictext within w_int_movalm_compras
end type
type pb_1 from upb_salir within w_int_movalm_compras
end type
type em_fecha from u_em_campo within w_int_movalm_compras
end type
type sle_tipomov from u_em_campo within w_int_movalm_compras
end type
type sle_numdoc from u_em_campo within w_int_movalm_compras
end type
type em_cantidad from u_em_campo within w_int_movalm_compras
end type
type sle_observaciones from u_em_campo within w_int_movalm_compras
end type
type sle_proveedor from u_em_campo within w_int_movalm_compras
end type
type cb_1 from u_boton within w_int_movalm_compras
end type
type cb_4 from u_boton within w_int_movalm_compras
end type
type cb_3 from u_boton within w_int_movalm_compras
end type
type cb_borrar from u_boton within w_int_movalm_compras
end type
type uo_mprima from u_em_campo_2 within w_int_movalm_compras
end type
type uo_calidad from u_em_campo_2 within w_int_movalm_compras
end type
type pb_calculadora from u_calculadora within w_int_movalm_compras
end type
type pb_borrar from upb_papelera within w_int_movalm_compras
end type
type p_proveedor from up_carpeta within w_int_movalm_compras
end type
type st_tecla from statictext within w_int_movalm_compras
end type
type pb_imprimir_preli from picturebutton within w_int_movalm_compras
end type
type dw_listado from datawindow within w_int_movalm_compras
end type
type cb_5 from commandbutton within w_int_movalm_compras
end type
type st_1 from statictext within w_int_movalm_compras
end type
type cb_2 from u_boton within w_int_movalm_compras
end type
type dw_4 from datawindow within w_int_movalm_compras
end type
type dw_comlinubicahis from datawindow within w_int_movalm_compras
end type
type dw_3 from datawindow within w_int_movalm_compras
end type
type dw_1 from datawindow within w_int_movalm_compras
end type
end forward

global type w_int_movalm_compras from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2967
integer height = 1604
string icon = "\bmp\RINO.ICO"
st_13 st_13
st_12 st_12
st_11 st_11
st_texto_cantidad st_texto_cantidad
st_2 st_2
st_nombre_tipomov st_nombre_tipomov
st_9 st_9
st_proveedor_etiqueta st_proveedor_etiqueta
st_nombre_proveedor st_nombre_proveedor
pb_1 pb_1
em_fecha em_fecha
sle_tipomov sle_tipomov
sle_numdoc sle_numdoc
em_cantidad em_cantidad
sle_observaciones sle_observaciones
sle_proveedor sle_proveedor
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
cb_borrar cb_borrar
uo_mprima uo_mprima
uo_calidad uo_calidad
pb_calculadora pb_calculadora
pb_borrar pb_borrar
p_proveedor p_proveedor
st_tecla st_tecla
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
cb_5 cb_5
st_1 st_1
cb_2 cb_2
dw_4 dw_4
dw_comlinubicahis dw_comlinubicahis
dw_3 dw_3
dw_1 dw_1
end type
global w_int_movalm_compras w_int_movalm_compras

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
   str_comlinubicahis  ubihis
   str_comlinubica      ubi
   str_commovhis       mov

end variables

forward prototypes
public subroutine ver_movimientos ()
public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones)
public subroutine f_procesar_entrada ()
end prototypes

public subroutine ver_movimientos ();If Trim(sle_tipomov.text) = "" or Trim(sle_numdoc.text) = "" Then
  dw_3.Reset()
Else
  dw_3.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
End If
end subroutine

public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones);Integer orden
DateTime   fecha
Select Max(orden) Into :orden From almlinubica_observaciones
Where  almlinubica_observaciones.empresa   = :codigo_empresa
And    almlinubica_observaciones.ubicacion = :ubicacion
And    almlinubica_observaciones.linea     = :linea;
IF IsNull(orden) Then orden = 0
orden = orden +1
fecha = DateTime(Today(),Now())
  INSERT INTO almlinubica_observaciones  
         ( empresa,   
           ubicacion,   
           linea,   
           orden,   
           fecha,   
           usuario,   
           observaciones )  
  VALUES ( :empresa,   
           :ubicacion,   
           :linea,   
           :orden,   
           :fecha,   
           :nombre_usuario,   
           :observaciones )  ;
		




end subroutine

public subroutine f_procesar_entrada ();//---------------------//
// Control Ubicaciones //
//---------------------//

String antealmacen
dec y1,longitudes
Date fecha
Dec numero,controles,x2,x1
Decimal{4} total_cantidad
string mensaje,nombre,campo,cur_mp

controles  = 0
contador = dw_1.Rowcount()
IF contador=0 THEN
 	MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
 	Return
END IF
dw_1.Accepttext()

FOR x2=1 TO contador
 	v_almacen    = dw_1.GetItemString(x2,"almacen")	
 	v_zona       = dw_1.GetItemString(x2,"zona")	
 	v_fila       = dw_1.GetItemNumber(x2,"fila")	
 	v_altura     = dw_1.GetItemNumber(x2,"altura")	
 	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
 	IF IsNull(v_fila)   Then v_fila = 0
 	IF IsNull(v_altura) Then v_altura = 0

 
	IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
 		controles=1
 		campo="almacen"
 		mensaje=" Introduzca el almacen "
	END IF

	If x2 > 1 Then
 		IF antealmacen<> v_almacen THEN
  			campo="almacen"
  			controles=1
  			mensaje=" Todos los Movimientos Deben de ubicarse en un mismo almacén "
 		END IF
	END IF

	IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
 		controles=1
 		campo="zona"
 		mensaje=" Introduzca la zona "
	END IF

	IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
 		controles=1
 		campo="fila"
 		mensaje= "Introduzca la fila de la ubicación"
	END IF

	IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
 		controles=1
 		campo="altura"
 		mensaje= "Introduzca la altura de la ubicación"
	END IF

	IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
 		controles=1
 		campo="cantidad"
 		mensaje= "Introduzca la cantidad"
	END IF

	nombre=f_nombre_comalmacen_abr(codigo_empresa,v_almacen)
	IF (trim(nombre)="") and controles=0 THEN
  		mensaje="El almacén no existe "
  		controles=1
  		campo="almacen"
	END IF

	nombre=f_nombre_zona_compras(codigo_empresa,v_almacen,v_zona)
	IF (trim(nombre)="") and controles=0 THEN
   		mensaje="La zona no existe"
   		controles=1
   		campo="zona"
	END IF

 	IF (Not(f_ubi_exist_compras(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    		mensaje= "La ubicación no está contemplada en el mapa de ubicaciones"
    		controles=1
    		campo="almacen"
 	END IF

	IF controles=1 THEN
  		MessageBox("Campo obligatorio en línea "+string(x2),mensaje,Exclamation!, OK!,1)
  		dw_1.SetColumn(campo)
  		dw_1.setRow(x2)
  		dw_1.setfocus()
 		Return
	END IF
	antealmacen = v_almacen
NEXT

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
IF total_cantidad<>Dec(em_cantidad.text) THEN
  	MessageBox("No Puedo Procesar","El total no coincide",Exclamation!, OK!,1)
  	Return
END IF

pb_1.enabled=FALSE

IF Not f_bloquear_almacen_compras(w_int_movalm_compras.title) Then
//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------
// Contador de movimiento y orden de lineas de  ubicacion
	Dec contador_nummov,contador_orden 

// Valor de controles funcionamiento
   	dec bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 	ubihis.usuario       = nombre_usuario
	mov.usuario          = nombre_usuario
	ubihis.empresa       = codigo_empresa
	ubihis.anyo          = year(date(String(em_fecha.text)))
	ubihis.almacen       = v_almacen
	ubihis.mp		       = uo_mprima.em_codigo.text
	ubihis.calidad       = uo_calidad.em_codigo.text
	ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
	ubihis.f_alta        = DateTime(Today(),now())
	ubihis.observaciones = sle_observaciones.text
	ubihis.tipomov       = sle_tipomov.text


  	SELECT venmprima.familia,venmprima.tipo_unidad,venmprima.envase
	INTO :ubihis.familia,:ubihis.tipo_unidad,:ubihis.envase
	FROM venmprima
	WHERE venmprima.empresa= :ubihis.empresa
	AND   venmprima.codigo = :ubihis.mp ;
	IF SQLCA.SQLCode<>0 THEN bien=1

	mov.envase  = 	ubihis.envase
	ubi.empresa    =  ubihis.empresa
	ubi.almacen    =  ubihis.almacen
	ubi.mp		   =  ubihis.mp
	ubi.familia    =  ubihis.familia
	ubi.calidad    =  ubihis.calidad
	ubi.tipo_unidad=  ubihis.tipo_unidad
	ubi.f_alta     =  Datetime(today(),now())
	// Valor movimiento historico
	mov.empresa    =  ubihis.empresa
	mov.almacen    =  ubihis.almacen
	mov.mp		   =  ubihis.mp
	mov.familia    =  ubihis.familia
	mov.calidad    =  ubihis.calidad
	mov.tipo_unidad=  ubihis.tipo_unidad
	mov.f_alta     =  DateTime(Today(),now())
	fecha          =  Date(String(em_fecha.text))
	mov.anyo       =  year(fecha)
	//****
	mov.origen     = "1"
	mov.fechmov    = ubihis.fecha
	mov.tipomov    = ubihis.tipomov
	mov.cantidade  = Dec(em_cantidad.text)
	mov.cantidads  =0
	mov.precio     =0
	IF f_tipo_almtipomov(codigo_empresa,mov.tipomov)="P"  THEN
	  	mov.codtercero=sle_proveedor.text
	ELSE
	  	SetNull(mov.codtercero)
	END IF
	mov.numdoc        = sle_numdoc.text
	mov.situacion     = "N"
	mov.observaciones = sle_observaciones.text
	// Variable utilizada para montaje observaciones en lineas de ubicacion
  	String var_observaciones
	//-------------------------------------------------------------------
  	contador_nummov= f_comparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
	contador_orden = f_comparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
	mov.nummov     = contador_nummov
	ubihis.nummov  = contador_nummov
	ubihis.orden   = contador_orden
	contador = dw_1.Rowcount()

  	FOR x2=1 TO contador
		ubihis.zona       = dw_1.GetItemString(x2,"zona")	
	  	ubihis.fila       = dw_1.GetItemNumber(x2,"fila")	
	  	ubihis.altura     = dw_1.GetItemNumber(x2,"altura")	
	  	IF IsNull(ubihis.altura) Then ubihis.altura = 0
	  	ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")	
	  	ubihis.orden      = contador_orden
	  	ubihis.nummov     = contador_nummov
	  	ubihis.observaciones  = mov.observaciones
	  	ubihis.f_alta     = DateTime(Today(),now())
	  	ubihis.usuario    = nombre_usuario
	  	ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
															 ubihis.fila,ubihis.altura)
	  	ubihis.cantidads    = 0
	  	ubi.zona            = ubihis.zona
	  	ubi.fila            = ubihis.fila
	  	ubi.altura          = ubihis.altura
	  	ubi.existencias     = ubihis.cantidade
	  	ubi.ubicacion       = ubihis.ubicacion
	  	//------------------------------------------------------------------
	  	// Inserto en el historico de lineas de ubicacion por movimiento
	  	//------------------------------------------------------------------
	  	ubihis.observaciones =  String(today(),"dd/mm/yy") + "-" + sle_observaciones.text  
	  	IF Not f_insert_comlinubicahis(ubihis) Then  bien=1
	  
    
		//-----------------------------------------------------------------------
		// Variables para cargar el cursor
		//-----------------------------------------------------------------------
      	String cur_empresa,cur_almacen
      	dec cur_pedido,cur_linea,cur_anyo
      	decimal{4}  cur_existencias
      	string  cur_referencia,cur_ubicacion,cur_tipo_pallet
     
		//----------------------------------------------------------
		// Busco si hay linea este articulo sin reservar
		//---------------------------------------------------------
		dec registros
		String sel
		DataStore dw_proceso 
		Sel = " SELECT   linea,existencias  " + &
				" FROM     comlinubica  " + &
				" WHERE    comlinubica.empresa    = '"+ codigo_empresa  + "'" +&
				" AND      comlinubica.ubicacion  = '"+ ubi.ubicacion + "'" +&
				" AND      comlinubica.mp = '"+ ubi.mp + "'" +&
				" AND      comlinubica.calidad = '"+ ubi.calidad + "'" 		

//		dw_proceso = f_cargar_cursor2(sel)
		f_cargar_cursor_nuevo(sel, dw_proceso)
		registros = dw_proceso.RowCount()
		dec grabado,salir
		grabado=0
		salir  =0
		IF registros<>0 THEN
			FOR x1 = 1 To registros
  				cur_empresa       =   codigo_empresa
				cur_almacen       =   f_almacen_ubicacion(ubi.ubicacion)
  				cur_ubicacion     =   ubi.ubicacion
  				cur_mp    			=   ubi.mp

  				cur_existencias   =   dw_proceso.GetItemNumber(x1,"existencias")

  				cur_linea         =   dw_proceso.GetItemNumber(x1,"linea")
  				grabado = 1
     			ubi.existencias=ubi.existencias + cur_existencias
       			UPDATE comlinubica  
       			SET existencias   = :ubi.existencias,   
       			f_alta            = :ubi.f_alta
       			WHERE  comlinubica.empresa   = :ubi.empresa 
		 		AND    comlinubica.ubicacion = :ubi.ubicacion 
		 		AND    comlinubica.linea     = :cur_linea  USING SQLCA;
       			IF SQLCA.SQLCode<>0 THEN  bien=1
       			EXIT
			NEXT
		END IF
		IF grabado=0 THEN
    			cur_linea=0
   			SELECT  max(comlinubica.linea)  INTO :cur_linea FROM comlinubica  
   			WHERE   comlinubica.empresa   = :ubi.empresa 
			AND     comlinubica.ubicacion = :ubi.ubicacion;
   			IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
    				cur_linea = 0 
   			END IF
    			cur_linea=cur_linea+1
			ubi.linea=cur_linea
			SetNull(ubi.observaciones)
			IF NOT f_insert_comlinubica(ubi) Then  bien=1
		END IF
		//-----------------------Fin Grabación Lineas de Ubicacion--------------
		// el contador incrementa uno para cada linea
     	contador_orden = contador_orden + 1
NEXT

 // Grabar el movimiento en el historico por el total de existencias
IF NOT f_insert_commovhis(mov) Then
      MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
      bien=1
END IF
IF NOT f_actualiza_nummov_compras(mov.empresa,Year(Date(em_fecha.text)),mov.nummov) THEN
	bien=1
END IF
IF NOT f_actualiza_numorden_compras(ubihis.empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
	bien=1
END IF

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
  	f_desbloquear_almacen_compras(w_int_movalm_compras.title)
  	pb_1.enabled=TRUE
	cb_3.TriggerEvent(Clicked!)
END IF

destroy dw_proceso
end subroutine

on ue_f5;call w_int_con_empresa::ue_f5;IF pb_calculadora.visible = FALSE Then Return
pb_calculadora.TriggerEvent(Clicked!)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción Entradas Almacén Materias Primas"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
em_fecha.text=string(today())
dw_3.Settransobject(SQLCA)
dw_4.Settransobject(SQLCA)
dw_listado.Settransobject(SQLCA)
dw_comlinubicahis.Settransobject(SQLCA)

end event

on w_int_movalm_compras.create
int iCurrent
call super::create
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_texto_cantidad=create st_texto_cantidad
this.st_2=create st_2
this.st_nombre_tipomov=create st_nombre_tipomov
this.st_9=create st_9
this.st_proveedor_etiqueta=create st_proveedor_etiqueta
this.st_nombre_proveedor=create st_nombre_proveedor
this.pb_1=create pb_1
this.em_fecha=create em_fecha
this.sle_tipomov=create sle_tipomov
this.sle_numdoc=create sle_numdoc
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.sle_proveedor=create sle_proveedor
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_borrar=create cb_borrar
this.uo_mprima=create uo_mprima
this.uo_calidad=create uo_calidad
this.pb_calculadora=create pb_calculadora
this.pb_borrar=create pb_borrar
this.p_proveedor=create p_proveedor
this.st_tecla=create st_tecla
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.cb_5=create cb_5
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_4=create dw_4
this.dw_comlinubicahis=create dw_comlinubicahis
this.dw_3=create dw_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_13
this.Control[iCurrent+2]=this.st_12
this.Control[iCurrent+3]=this.st_11
this.Control[iCurrent+4]=this.st_texto_cantidad
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_nombre_tipomov
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.st_proveedor_etiqueta
this.Control[iCurrent+9]=this.st_nombre_proveedor
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.em_fecha
this.Control[iCurrent+12]=this.sle_tipomov
this.Control[iCurrent+13]=this.sle_numdoc
this.Control[iCurrent+14]=this.em_cantidad
this.Control[iCurrent+15]=this.sle_observaciones
this.Control[iCurrent+16]=this.sle_proveedor
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.cb_4
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.cb_borrar
this.Control[iCurrent+21]=this.uo_mprima
this.Control[iCurrent+22]=this.uo_calidad
this.Control[iCurrent+23]=this.pb_calculadora
this.Control[iCurrent+24]=this.pb_borrar
this.Control[iCurrent+25]=this.p_proveedor
this.Control[iCurrent+26]=this.st_tecla
this.Control[iCurrent+27]=this.pb_imprimir_preli
this.Control[iCurrent+28]=this.dw_listado
this.Control[iCurrent+29]=this.cb_5
this.Control[iCurrent+30]=this.st_1
this.Control[iCurrent+31]=this.cb_2
this.Control[iCurrent+32]=this.dw_4
this.Control[iCurrent+33]=this.dw_comlinubicahis
this.Control[iCurrent+34]=this.dw_3
this.Control[iCurrent+35]=this.dw_1
end on

on w_int_movalm_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_texto_cantidad)
destroy(this.st_2)
destroy(this.st_nombre_tipomov)
destroy(this.st_9)
destroy(this.st_proveedor_etiqueta)
destroy(this.st_nombre_proveedor)
destroy(this.pb_1)
destroy(this.em_fecha)
destroy(this.sle_tipomov)
destroy(this.sle_numdoc)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.sle_proveedor)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_borrar)
destroy(this.uo_mprima)
destroy(this.uo_calidad)
destroy(this.pb_calculadora)
destroy(this.pb_borrar)
destroy(this.p_proveedor)
destroy(this.st_tecla)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_4)
destroy(this.dw_comlinubicahis)
destroy(this.dw_3)
destroy(this.dw_1)
end on

event ue_listar;Integer opc
tipo_array arg


dw_listado.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_tipomov.text,sle_numdoc.text)
dw_report = dw_listado
CALL Super::ue_listar
end event

event activate;call super::activate;w_int_movalm_compras = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movalm_compras
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movalm_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movalm_compras
integer width = 2656
integer height = 108
end type

type st_13 from statictext within w_int_movalm_compras
integer x = 832
integer y = 184
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Docu."
boolean focusrectangle = false
end type

type st_12 from statictext within w_int_movalm_compras
integer x = 14
integer y = 340
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Mvto"
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_movalm_compras
integer x = 50
integer y = 172
integer width = 247
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_movalm_compras
integer x = 946
integer y = 444
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

type st_2 from statictext within w_int_movalm_compras
integer x = 827
integer y = 444
integer width = 110
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

type st_nombre_tipomov from statictext within w_int_movalm_compras
integer x = 626
integer y = 328
integer width = 823
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movalm_compras
integer x = 46
integer y = 624
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

type st_proveedor_etiqueta from statictext within w_int_movalm_compras
boolean visible = false
integer x = 1499
integer y = 252
integer width = 315
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
string text = "Proveedor"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_proveedor from statictext within w_int_movalm_compras
boolean visible = false
integer x = 1989
integer y = 340
integer width = 923
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movalm_compras
integer x = 2725
integer y = 40
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
alignment htextalign = right!
end type

type em_fecha from u_em_campo within w_int_movalm_compras
integer x = 329
integer y = 172
integer width = 347
integer taborder = 20
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

on modified;call u_em_campo::modified;ver_movimientos()
end on

type sle_tipomov from u_em_campo within w_int_movalm_compras
integer x = 320
integer y = 324
integer width = 288
integer taborder = 30
end type

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_comtipomov(codigo_empresa,sle_tipomov.text)
IF LEN(st_nombre_tipomov.text)=0 THEN 
   IF LEN(sle_tipomov.text)<>0 Then f_activar_campo(sle_tipomov)
   sle_tipomov.text="" 
   Return
END IF
IF f_interno_comtipomov(codigo_empresa,sle_tipomov.text)= "S" Or&
    f_codigo_real_comtipomov(codigo_empresa,sle_tipomov.text)<> "E"  Then
 sle_tipomov.text="" 
 st_nombre_tipomov.text = ""
END IF







ver_movimientos()

// Para Entradas de compras saco el proveedor

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text) = "P"  THEN
  st_nombre_proveedor.visible  = TRUE
  sle_proveedor.visible        = TRUE
  st_proveedor_etiqueta.visible= TRUE
  p_proveedor.visible          = TRUE

  // recojo el proveedor en caso de compras
   integer registros
   string v_proveedor
   registros = dw_3.RowCount()
    IF registros >0 THEN
      v_proveedor = dw_3.GetItemString(1,"almmovhis_codtercero")
      sle_proveedor.text = v_proveedor
      st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
   END IF
ELSE
  st_nombre_proveedor.visible  = FALSE
  sle_proveedor.visible        = FALSE
  st_proveedor_etiqueta.visible= FALSE
  p_proveedor.visible          = FALSE
END IF
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos"
ue_datawindow = "dw_ayuda_comtipomov"
ue_filtro     = "interno = 'N' and codigo_real = 'E'"
end event

type sle_numdoc from u_em_campo within w_int_movalm_compras
integer x = 1093
integer y = 176
integer taborder = 40
string mask = "##########"
end type

event modificado;call super::modificado;if ante_numdoc=sle_numdoc.text then return

if trim(sle_numdoc.text)<>"" then
   
   ver_movimientos()

   // recojo el proveedor en caso de compras
 
   IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
      integer registros
      string v_proveedor
      registros = dw_3.RowCount()
      IF registros >0 THEN
          v_proveedor = dw_3.object.codtercero[1]//(1,"commovhis_codtercero")
          sle_proveedor.text = v_proveedor
          st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
      END IF

   END IF

   pb_calculadora.visible = FALSE
   st_tecla.visible = FALSE
    
End If
end event

on getfocus;call u_em_campo::getfocus;pb_calculadora.visible = TRUE
   st_tecla.visible = TRUE
ante_numdoc = sle_numdoc.text
end on

type em_cantidad from u_em_campo within w_int_movalm_compras
integer x = 942
integer y = 520
integer width = 384
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###.00"
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
situado= "CANTIDAD"
end event

event modificado;call super::modificado;//If ante_valor<>Dec(em_cantidad.text) THEN
// em_cajas.text=""
// em_t_cajas.text=""
// em_t_pallets.text=""
//END  IF
//
// string cadena
// cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
//                            uo_tipo_pallet.em_codigo.text,&
//									 uo_caja.em_codigo.text,&
//                            integer(em_t_pallets.text),&
//                            integer(em_cajas.text),&
//                            Dec(em_cantidad.text))
//                       
// em_t_pallets.text  =Mid(cadena,1,6)
// em_cajas.text      =Mid(cadena,7,6)
// em_t_cajas.text    =Mid(cadena,13,6)
// em_cantidad.text   =Mid(cadena,19,9)
//
//if especial and Dec(em_cantidad.text) > ante_cant then
//	f_mensaje("Modificación de líneas","Sólo se permiten modificaciones a la baja")
//	f_activar_campo (em_cantidad)
//	em_cantidad.text = String(ante_cant)
//end if
end event

type sle_observaciones from u_em_campo within w_int_movalm_compras
integer x = 539
integer y = 624
integer width = 1847
integer taborder = 120
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;situado= "OBSERVACIONES"
end event

type sle_proveedor from u_em_campo within w_int_movalm_compras
boolean visible = false
integer x = 1467
integer y = 336
integer width = 402
integer taborder = 60
boolean bringtotop = true
end type

event modificado;call super::modificado;Integer x1 
st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
IF Trim(em_fecha.text)    = "" or IsNull(em_fecha.text) or &
   Trim(sle_numdoc.text)  = "" or IsNull(sle_numdoc.text) or&
   Trim(sle_tipomov.text) = "" or IsNull(sle_tipomov.text) THEN
   sle_proveedor.text     = ""
   Return
END IF

IF LEN(st_nombre_proveedor.text)=0 THEN 
   IF LEN(sle_tipomov.text)<>0 Then f_activar_campo(sle_proveedor)
   sle_proveedor.text="" 
   Return
END IF

IF Trim(sle_proveedor.text)=""  or  IsNull(sle_proveedor) THEN
	f_activar_campo(sle_proveedor)
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
   // controlo que los movimientos de compras ya introducidos a la factura
   // en curso pertenezcan al mismo codigo de proveedor
   String  v_proveedor
   Integer registros
   registros = dw_3.RowCount()
   IF registros >0 THEN
      v_proveedor = dw_3.GetItemString(1,"almmovhis_codtercero")
     
      IF trim(sle_proveedor.text)="" THEN
         sle_proveedor.text=v_proveedor
      END IF
      IF Trim(st_nombre_proveedor.text)="" THEN
         MessageBox("Mensaje","El proveedor no existe",Exclamation!,Ok!,1)
         sle_proveedor.text= v_proveedor
         st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
         sle_proveedor.Setfocus()
         Return
      END IF
      IF v_proveedor<>sle_proveedor.text or IsNull(v_proveedor) THEN
        integer opcion,bien
        opcion=MessageBox("Todas las lineas deben de ser al mismo proveedor","El proveedor no coincide con los demas movimientos ¿Validar?",Question!,YesNo!,2)
        
        CHOOSE CASE opcion
	     CASE 1 
              bien=0
              titulo        =  Parent.title
              longitud      =  len(trim(codigo_empresa))
              criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
              anyo          =  year(today())
              longitud      =  len(trim(string(anyo)))
              criterio[2]   =  trim(string(anyo))+space(20-longitud)
              v_almacen     =  dw_3.GetItemString(1,"almmovhis_almacen")
              longitud      =  len(trim(v_almacen))
              criterio[3]   =  trim(v_almacen)+space(20-longitud)
              seleccion     =  criterio[1]+criterio[2]+criterio[3]
              tabla         =  "almparam"
           IF NOT f_bloquear(tabla,seleccion,titulo) THEN 
              FOR x1=1 TO registros
               mov.empresa =codigo_empresa
               mov.almacen = v_almacen
               mov.anyo    = anyo
               mov.nummov  = dw_3.GetItemNumber(x1,"almmovhis_nummov")
               UPDATE almmovhis  
               SET codtercero= :sle_proveedor.text  
               WHERE (almmovhis.empresa = :mov.empresa ) AND  
                     (almmovhis.almacen = :mov.almacen ) AND  
                     (almmovhis.anyo    = :mov.anyo    ) AND  
                     (almmovhis.nummov  = :mov.nummov  ) USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN
                  bien=1
               END IF
             NEXT
             IF bien=0 THEN
                COMMIT USING SQLCA;
             ELSE
                ROLLBACK USING SQLCA;
                MessageBox("Error en base de datos","Error el procesar datos",Exclamation!,Ok!,2)
             END IF
             f_desbloquear(tabla,seleccion,titulo)
             ver_movimientos()
          ELSE
             sle_proveedor.text= v_proveedor
             st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
          END IF
        CASE 2 
             sle_proveedor.text= v_proveedor
             st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
        END CHOOSE

      END IF
   END IF
END IF
end event

event getfocus;call super::getfocus; ue_filtro = ""
 ue_titulo      = "Ayuda seleccion de proveedores" 
 ue_datawindow  = "dw_ayuda_proveedores"
 
 
end event

type cb_1 from u_boton within w_int_movalm_compras
integer x = 1339
integer y = 484
integer width = 151
integer height = 128
integer taborder = 130
string text = "&OK"
end type

event clicked;//CONTROLES DE VALORES

string mensaje
// piezas por conjunto
Dec{2} var_conjunto

dw_1.reset()

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF


IF trim(sle_tipomov.text)=""  or IsNull(sle_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF


st_nombre_tipomov.text=f_nombre_comtipomov(codigo_empresa,sle_tipomov.text)
IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="P" THEN
  st_nombre_proveedor.text=f_nombre_proveedor(codigo_empresa,sle_proveedor.text)
  IF trim(st_nombre_proveedor.text)="" or IsNull(st_nombre_proveedor.text) THEN
   mensaje="El proveedor no existe."
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_proveedor.Setfocus()
   RETURN
 END IF
END IF

IF trim(sle_numdoc.text)="" THEN
   mensaje="Introduzca el Numero de Dmto"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_numdoc.Setfocus()
   RETURN
END IF

IF trim(uo_mprima.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_mprima.em_campo.Setfocus()
   RETURN
END IF


 IF trim(uo_calidad.em_campo.text)="" THEN
   mensaje="Introduzca la calidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   uo_calidad.em_campo.Setfocus()
   RETURN
 END IF

IF trim(em_cantidad.text)="" THEN
   mensaje="Introduzca la cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

string codigo_real
String codigo_tipomov
codigo_tipomov=sle_tipomov.text

SELECT comtipomov.codigo_real  
INTO :codigo_real  
FROM comtipomov  
WHERE (comtipomov.empresa = :codigo_empresa ) AND  
         (comtipomov.tipomov = :codigo_tipomov)  USING SQLCA  ;
			
IF codigo_real<>"E" THEN
   MessageBox("Tipo de Movimiento no válido","Solo se permiten movimiento de entradas ",Exclamation!, OK!,1)
   sle_tipomov.text=""
   sle_tipomov.Setfocus()
   Return	
END IF

dw_1.visible=TRUE
dw_3.visible=FALSE
dw_4.visible=TRUE
cb_2.visible=TRUE
cb_3.visible=TRUE
cb_4.visible =TRUE
cb_borrar.visible=TRUE
pb_borrar.visible=FALSE

dw_1.retrieve()
contador=dw_1.Rowcount()

dw_4.retrieve(codigo_empresa,uo_mprima.em_codigo.text)

contador=contador+1

// entrada normal
dw_1.insertRow(contador)
dw_1.setitem(contador,"almacen",f_almacen_mprima(codigo_empresa,uo_mprima.em_codigo.text))
dw_1.setitem(contador,"cantidad",dec(em_cantidad.text))
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(contador,"tipo_unidad",f_codigo_mp_unidad(codigo_empresa,uo_mprima.em_codigo.text))

dw_1.SetTabOrder("almacen",10)
dw_1.SetTabOrder("zona",20)
dw_1.SetTabOrder("fila",30)
dw_1.SetTabOrder("altura",40)		
dw_1.SetTabOrder("cantidad",50)			


dw_1.SetFocus()


end event

type cb_4 from u_boton within w_int_movalm_compras
boolean visible = false
integer x = 1271
integer y = 1288
integer width = 439
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;f_procesar_entrada()




end event

type cb_3 from u_boton within w_int_movalm_compras
boolean visible = false
integer x = 850
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;em_fecha.enabled        = TRUE
em_cantidad.enabled     = TRUE
uo_mprima.em_campo.enabled    = TRUE
uo_calidad.em_campo.enabled     = TRUE
sle_numdoc.enabled      = TRUE
sle_tipomov.enabled     = TRUE
sle_observaciones.enabled = TRUE
sle_proveedor.enabled     = TRUE
cb_1.enabled            = TRUE
dw_4.visible            = FALSE

dw_1.visible            = FALSE
dw_3.visible            = TRUE
cb_2.visible      = FALSE
cb_3.visible      = FALSE
cb_4.visible      = FALSE
cb_borrar.visible = FALSE
ver_movimientos()
em_cantidad.text=""
uo_mprima.em_campo.text=""
uo_calidad.em_campo.text=""
uo_calidad.em_codigo.text=""
uo_mprima.em_codigo.text=""
sle_observaciones.text=""

uo_mprima.em_campo.SetFocus()
end event

type cb_borrar from u_boton within w_int_movalm_compras
boolean visible = false
integer x = 430
integer y = 1288
integer width = 421
integer height = 88
integer taborder = 0
boolean bringtotop = true
string text = "&Borrar"
end type

event clicked;call super::clicked;integer fila
fila=dw_1.getrow()
IF contador=fila THEN
  IF contador<>1 THEN
    contador=contador - 1
  END IF
END IF
IF fila<>0 THEN
 dw_1.DeleteRow(dw_1.getRow())
 dw_1.setrowfocusIndicator(Hand!)
 dw_1.SetColumn("almacen")
 dw_1.setRow(contador)
 dw_1.setfocus()
END IF

end event

type uo_mprima from u_em_campo_2 within w_int_movalm_compras
integer x = 14
integer y = 520
integer width = 809
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_cliente
uo_mprima.em_campo.text=Trim(f_nombre_mprima(codigo_empresa,uo_mprima.em_codigo.text))
IF Trim(uo_mprima.em_campo.text)="" THEN 
 IF Trim(uo_mprima.em_codigo.text)<>"" Then 
	uo_mprima.em_campo.SetFocus()
END IF
 uo_mprima.em_campo.text=""
 uo_mprima.em_codigo.text=""
 Return
END IF




 // Selecciono abreviado de la unidad del articulo
  string  codigo_mp,texto_unidad,cod_familia

  codigo_mp = uo_mprima.em_codigo.text
  mov.mp    = codigo_mp


  SELECT venmprima.familia, venmprima.tipo_unidad
    INTO :mov.familia,:mov.tipo_unidad
    FROM venmprima  
   WHERE venmprima.empresa = :codigo_empresa 
	AND   venmprima.codigo  = :codigo_mp;


st_texto_cantidad.text=f_nombre_unimedida(mov.tipo_unidad)
em_cantidad.Setmask(NumericMask!,f_mascara_unidad_compras(mov.tipo_unidad))


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de materias primas"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""

end event

on uo_mprima.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_movalm_compras
integer x = 823
integer y = 520
integer width = 110
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then
	uo_calidad.em_campo.SetFocus()
END IF
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_calculadora from u_calculadora within w_int_movalm_compras
boolean visible = false
integer x = 1335
integer y = 172
integer taborder = 0
end type

event clicked;String com_empresa,com_tipomov
Dec com_anyo,com_numdoc

com_empresa    =  codigo_empresa
com_anyo       =  Year(Date(em_fecha.text))
com_tipomov    =  sle_tipomov.text
com_numdoc     =  Dec(sle_numdoc.text)

SELECT     max(convert(dec,commovhis.numdoc))
    INTO  :com_numdoc  
    FROM   commovhis  
    WHERE  commovhis.empresa  = :com_empresa 
	 AND    commovhis.anyo     = :com_anyo 
	 AND    commovhis.tipomov  = :com_tipomov;
	 
	 
	 
    IF SQLCA.SQLCode<>0 THEN   com_numdoc=0
    IF IsNUll(com_numdoc) Then com_numdoc = 0

   com_numdoc      = com_numdoc + 1
 	sle_numdoc.text = string(com_numdoc,"#######")
   ver_movimientos()
   sle_numdoc.SetFocus()
end event

type pb_borrar from upb_papelera within w_int_movalm_compras
boolean visible = false
integer x = 2112
integer y = 488
integer width = 123
integer height = 96
integer taborder = 70
boolean originalsize = false
end type

event clicked;if dw_3.GetRow()=0 Then Return

dec opcion
opcion=MessageBox("Proceso de borrado de datos","¿Borrar la entrada seleccionada?",question!, YesNo!,2)

IF opcion=2 THEN  Return

dec registros,x2,bien
string  cod_ubicacion,mp
decimal{2} total_cantidad,mod_cantidad
bien=0

registros = dw_comlinubicahis.RowCount()

IF registros=0 THEN  Return

 v_almacen     =  dw_comlinubicahis.GetItemString(1,"almacen") 
 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 anyo          =  dw_comlinubicahis.GetItemNumber(1,"anyo") 
 longitud      =  len(trim(string(anyo)))
 criterio[2]   =  trim(string(anyo))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]
 tabla         =  "comparam"
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
   COMMIT Using SQLCA; //Solucion nivel insolacion
 ubi.f_alta = DateTime(Today(),now())


ubihis.orden = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))

FOR x2=1 TO registros
 mp      	 		= dw_comlinubicahis.GetItemString(x2,"mp") 
 cod_ubicacion 		   = dw_comlinubicahis.GetItemString(x2,"ubicacion") 
 total_cantidad   		= dw_comlinubicahis.GetItemDecimal(x2,"cantidade")	
 
   //-------------------------------------------------------------
   // Busco si hay lineas este articulo sin reservar
   //-------------------------------------------------------------

dec elementos 
dec grabado,y2
grabado=0
String sel
DataStore dw_proceso 
Sel = " SELECT   linea,existencias  " + &
      " FROM     comlinubica  " + &
      " WHERE    comlinubica.empresa    = '"+ codigo_empresa  + "'" +&
		" AND      comlinubica.ubicacion  = '"+ cod_ubicacion + "'" +&
		" AND      comlinubica.mp = '"+ mp + "'" 
		
//dw_proceso = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dw_proceso)
elementos=dw_proceso.RowCOunt()
IF elementos=0 Then
	bien = 1
	f_mensaje("Error","No Stock para anular movimiento")
ELSE
 FOR y2= 1 to elementos

   ubi.empresa     =  codigo_empresa
   ubi.almacen     =  f_almacen_ubicacion(cod_ubicacion)
   ubi.ubicacion   =  cod_ubicacion
   ubi.mp  =  mp
   ubi.linea       =  dw_proceso.GetItemNumber(y2,"linea")
   ubi.existencias =  dw_proceso.GetItemNumber(y2,"existencias")
		
   IF IsNull(ubi.existencias) THEN ubi.existencias=0
	 IF ubi.existencias <=total_cantidad THEN
		    
          DELETE FROM comlinubica  
          WHERE comlinubica.empresa   = :ubi.empresa
			 AND   comlinubica.ubicacion = :ubi.ubicacion
			 AND   comlinubica.linea     = :ubi.linea ;
          IF SQLCA.SQLCode<>0 THEN  
				bien=1
				f_mensaje("Error","Al borrar ubicaciones")
			END IF
			total_cantidad = total_cantidad - ubi.existencias
     ELSE
       UPDATE comlinubica    SET existencias = existencias - :total_cantidad,   
                                 f_alta      = :ubi.f_alta  
       WHERE comlinubica.empresa   = :ubi.empresa 
		 AND   comlinubica.ubicacion = :ubi.ubicacion 
		 AND   comlinubica.linea     = :ubi.linea USING SQLCA;
       IF SQLCA.SQLCode<>0 THEN    
			bien=1
			f_mensaje("Error","Al modificar ubicaciones")
		 END IF
		 total_cantidad = 0
     END IF
     IF total_cantidad=0 THEN Exit
 NEXT
END IF
IF total_cantidad<>0 THEN   
	bien=1
	f_mensaje("Error", "Falta cantidad para anular")
END IF
ubihis.orden=ubihis.orden +1 
NEXT

destroy dw_proceso

//-------------------------------------------------------
// Borro el movimiento del historico
//-------------------------------------------------------
  dec{0}  mov_nummov,mov_anyo
  String   mov_situacion,mov_almacen,mov_empresa

 mov_nummov     = dw_comlinubicahis.GetItemNumber(1,"nummov") 
 mov_almacen    = dw_comlinubicahis.GetItemString(1,"almacen") 
 mov_empresa    = dw_comlinubicahis.GetItemString(1,"empresa")	
 mov_anyo       = dw_comlinubicahis.GetItemNumber(1,"anyo")	

 IF NOT f_anular_nummov_compras(mov_empresa,mov_almacen,mov_anyo,mov_nummov) THEN
	 f_mensaje("Error","Al anular el movimiento")
    bien=1
 END IF
 IF NOT f_actualiza_numorden_compras(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
     bien=1
	  f_mensaje("Error","Al actualizar el movimiento")
 END IF
 CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","No Puedo borrar el movimiento, el material ha sido reubicado",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE

 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT;
 ver_movimientos()
END IF
uo_mprima.em_campo.SetFocus()
end event

type p_proveedor from up_carpeta within w_int_movalm_compras
boolean visible = false
integer x = 1879
integer y = 340
integer width = 96
integer height = 76
end type

event clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos     = 3
lstr_param.s_argumentos[1]   = "w_int_movalm"
lstr_param.s_argumentos[2]   = "P"
lstr_param.s_argumentos[3]   = sle_proveedor.text

f_activar_campo(sle_proveedor)
OpenWithParm(wi_mant_clipro,lstr_param)  

end event

type st_tecla from statictext within w_int_movalm_compras
boolean visible = false
integer x = 1339
integer y = 268
integer width = 101
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F5"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_int_movalm_compras
event clicked pbm_bnclicked
integer x = 699
integer y = 168
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;Parent.TriggerEvent("ue_listar")
f_activar_campo(em_fecha)
end event

type dw_listado from datawindow within w_int_movalm_compras
boolean visible = false
integer x = 672
integer width = 457
integer height = 192
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_int_movalm_compras"
boolean border = false
boolean livescroll = true
end type

type cb_5 from commandbutton within w_int_movalm_compras
integer x = 18
integer y = 444
integer width = 805
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_mant_venmprima2, lstr_param)
end event

type st_1 from statictext within w_int_movalm_compras
integer x = 261
integer y = 448
integer width = 425
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
string text = "Materia Prima"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_mant_venmprima2, lstr_param)
end event

type cb_2 from u_boton within w_int_movalm_compras
boolean visible = false
integer x = 18
integer y = 1288
integer width = 411
integer height = 88
integer taborder = 0
string text = "&Insertar"
end type

event clicked;integer numero,controles
Dec{2} total_cantidad,total_pendiente
String ante_almacen
string mensaje,nombre,campo
controles=0
contador=dw_1.Rowcount()
dw_1.Accepttext()

IF contador<>0 THEN
 v_almacen  = dw_1.GetItemString(contador,"almacen")	
 v_zona     = dw_1.GetItemString(contador,"zona")	
 v_fila     = dw_1.GetItemNumber(contador,"fila")	
 v_altura   = dw_1.GetItemNumber(contador,"altura")	
 v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	

 
 IF (trim(v_almacen)="" or IsNull(v_almacen)) and controles=0 THEN
  controles=1
  campo="almacen"
  mensaje=" Introduzca el almacen " 
 END IF

 IF contador>1 THEN
    ante_almacen  = dw_1.GetItemString(contador - 1,"almacen")	
    IF ante_almacen<> v_almacen THEN
       controles = 1
       campo   = "almacen"
       mensaje = "Esta entrada a de ubicarse en el mismo almacen "
    END IF
 END IF
 IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
  controles=1
  campo="zona"
  mensaje=" Introduzca la zona "
 END IF
 IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
  controles=1
  campo="fila"
  mensaje= "Introduzca la fila de la ubicacion"
 END IF
 IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
  controles=1
  campo="altura"
  mensaje= "Introduzca la altura de la ubicacion"
 END IF
 IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
  controles=1
  campo="cantidad"
  mensaje= "Introduzca la cantidad"
 END IF

 nombre=f_nombre_almacen(codigo_empresa,v_almacen)
 IF (trim(nombre)="") and controles=0 THEN
   mensaje="El almacen no existe "
   controles=1
   campo="almacen"
 END IF

 nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
 IF (trim(nombre)="") and controles=0 THEN
    mensaje="La zona no existe"
    controles=1
    campo="zona"
 END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

 IF controles=1 THEN
  MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
  dw_1.SetColumn(campo)
  dw_1.setRow(contador)
  dw_1.setfocus()
  Return
 END IF
END IF

contador=contador+1
dw_1.InsertRow(contador)

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
total_pendiente = dec(em_cantidad.text)-total_cantidad

dw_1.setitem(contador,"cantidad",total_pendiente)
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(contador,"tipo_unidad",f_codigo_mp_unidad(codigo_empresa,uo_mprima.em_codigo.text))
IF contador > 1 THEN
    dw_1.setitem(contador,"almacen",v_almacen)
END  IF

dw_1.setrowfocusIndicator(Hand!)
IF contador=1 THEN
  dw_1.SetColumn("almacen")
ELSE
dw_1.SetColumn("zona")
END IF
dw_1.setRow(contador)
dw_1.setfocus()





end event

type dw_4 from datawindow within w_int_movalm_compras
boolean visible = false
integer x = 1710
integer y = 724
integer width = 1125
integer height = 564
string dataobject = "dw_int_comlinubi3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF dw_1.GetRow() <> 0 and This.GetRow()<> 0  Then
	dw_1.SetItem(dw_1.GetRow(),"almacen",This.GetItemSTring(This.getRow(),"almacen"))
	dw_1.SetItem(dw_1.GetRow(),"zona",This.GetItemSTring(This.getRow(),"zona"))
	dw_1.SetItem(dw_1.GetRow(),"fila",This.GetItemNumber(This.getRow(),"fila"))
	dw_1.SetItem(dw_1.GetRow(),"altura",This.GetItemNumber(This.getRow(),"altura"))
END IF
end event

type dw_comlinubicahis from datawindow within w_int_movalm_compras
boolean visible = false
integer y = 720
integer width = 1413
integer height = 684
boolean titlebar = true
string title = "Detalle ubicación de la linea "
string dataobject = "dw_int_comlinubi4"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event retrievestart;pb_borrar.visible=FALSE

end event

event retrieveend;IF dw_3.RowCount()>0 THEN
  pb_borrar.visible=TRUE
END IF
end event

type dw_3 from datawindow within w_int_movalm_compras
integer x = 59
integer y = 728
integer width = 2555
integer height = 700
string dataobject = "dw_int_comlinubi2"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "\bmp\RINO.ICO"
borderstyle borderstyle = styleraised!
end type

event retrieveend;pb_borrar.visible = False

if this.rowcount() > 0 then
	this.scrolltorow(this.rowcount())
end if

end event

event clicked;//IF row<>0 THEN
// //***
// //f_mensaje("art",GetItemString(row,"almmovhis_articulo"))
// //***
// integer registros
// registros = dw_3.RowCount()
// IF registros>0 THEN
// This.SelectRow(0,FALSE)
// This.SelectRow(row,TRUE)
// 
//  ubihis.anyo    =  GetItemNumber(row,"almmovhis_anyo")
//  ubihis.almacen =  GetItemString(row,"almmovhis_almacen")
//  ubihis.nummov  =  GetItemNumber(row,"almmovhis_nummov")
//  //f_mensaje ("anyo " + String(ubihis.anyo),"alm "+ubihis.almacen+" nummov "+String(ubihis.nummov))
//  dw_comlinubicahis.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
// END IF
// if especial then
//
//	if row = 0 Then Return
//	
//	uo_articulo.em_codigo.text = dw_3.GetItemString(row,"almmovhis_articulo")
//	uo_articulo.em_campo.text  = f_nombre_articulo (codigo_empresa,uo_articulo.em_codigo.text)
//	uo_calidad.em_codigo.text  = dw_3.GetItemString(row,"almmovhis_calidad")
//	uo_calidad.em_campo.text   = f_nombre_calidad_abr (codigo_empresa,uo_calidad.em_codigo.text)
//	em_tono.text 					= dw_3.GetItemString(row,"almmovhis_tonochar")
//	em_calibre.text 				= String(dw_3.GetItemNumber(row,"almmovhis_calibre"))
//	uo_caja.em_codigo.text  	= dw_3.GetItemString(row,"almmovhis_caja")
//	uo_caja.em_campo.text      = f_nombre_caja_abr (codigo_empresa,uo_caja.em_codigo.text)
//	uo_tipo_pallet.em_codigo.text= dw_3.GetItemString(row,"almmovhis_tipo_pallet")
//	uo_tipo_pallet.em_campo.text = f_nombre_pallet_abr (codigo_empresa,uo_tipo_pallet.em_codigo.text)
//	ante_cant						= dw_3.GetItemNumber(row,"almmovhis_cantidade")
//	em_cantidad.text  			= String(ante_cant)
//	em_cantidad.TriggerEvent("modificado")
//
// end if
//END IF
end event

event doubleclicked; dw_comlinubicahis.visible=TRUE
end event

type dw_1 from datawindow within w_int_movalm_compras
event key pbm_dwnkey
boolean visible = false
integer x = 9
integer y = 716
integer width = 1691
integer height = 564
boolean bringtotop = true
string dataobject = "dw_int_comlinubi1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;str_parametros param
String bus_campo,bus_cadena
dw_1.AcceptText()
param.b_empresa = TRUE
param.s_nom_datawindow   =  ""


IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 param.s_criterio_busqueda=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      	param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ALMACEN "
	 	param.s_nom_datawindow   = "dw_ayuda_comalmacenes"
      	param.s_filtro           = ""

	CASE "zona"
		
      	param.s_titulo_ayuda   = "VENTANA SELECCION DE ZONAS"
      	param.s_nom_datawindow = "dw_ayuda_comubizonas"
      	param.s_filtro         = "almacen = '"+This.object.almacen[This.GetRow()]+"'"
			
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return
  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""

IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
  param.s_criterio_busqueda  = bus_cadena
  OpenWithParm(w_busquedas,param)

  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()
END IF
END IF


end event

event rbuttondown; str_parametros param
 String bus_campo,bus_cadena

 param.b_empresa = TRUE
 
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "almacen"
      param.s_titulo_ayuda    = "VENTANA SELECCION DE TIPO DE ALMACENES"
 		param.s_nom_datawindow  = "dw_ayuda_comalmacenes"
   CASE "zona"
      param.s_titulo_ayuda   = "VENTANA SELECCION DE ZONAS"
      param.s_nom_datawindow = "dw_ayuda_comubizonas"
      param.s_filtro         = "almacen ='"+This.GetItemString(This.GetRow(),"almacen")+"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

// Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
  
  OpenWithParm(w_busquedas,param)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
    SetColumn(This.GetColumn())
    This.SetRow(This.getrow())
    This.Setfocus()

end event

