package de.janbellenberg.smarthome.service.api;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ResourceInfo;
import javax.ws.rs.core.Context;
import javax.ws.rs.ext.Provider;

@Provider
public class AuthenticationFilter implements ContainerRequestFilter {

  @Context
  private ResourceInfo resourceInfo;

  public static final String HEADER_NAME = "smarthome-session";

  @Override
  public void filter(ContainerRequestContext requestContext) {
    // TODO: implement auth filter
  }
}
